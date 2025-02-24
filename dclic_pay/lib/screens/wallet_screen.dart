import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallet_provider.dart';
import '../widgets/wallet_card.dart';
import '../models/transaction.dart'; // Import du modèle Transaction

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int _selectedWalletIndex = 0;
  String _selectedTimeRange = 'Week';

  // Fonction pour filtrer les transactions selon la période
  List<Transaction> _getFilteredTransactions(List<Transaction> transactions) {
    final now = DateTime.now();
    switch (_selectedTimeRange) {
      case 'Day':
        return transactions.where((t) {
          final transactionDate = DateTime.parse(t.timestamp);
          return transactionDate.year == now.year &&
              transactionDate.month == now.month &&
              transactionDate.day == now.day;
        }).toList();
      case 'Week':
        final weekAgo = now.subtract(const Duration(days: 7));
        return transactions.where((t) {
          final transactionDate = DateTime.parse(t.timestamp);
          return transactionDate.isAfter(weekAgo);
        }).toList();
      case 'Month':
        return transactions.where((t) {
          final transactionDate = DateTime.parse(t.timestamp);
          return transactionDate.year == now.year &&
              transactionDate.month == now.month;
        }).toList();
      default:
        return transactions;
    }
  }

  // Fonction pour générer les points du graphique
  List<FlSpot> _generateChartSpots(List<Transaction> transactions) {
    if (transactions.isEmpty) return [];

    final Map<int, double> dailyTotals = {};
    final filteredTransactions = _getFilteredTransactions(transactions);

    // Regrouper les transactions par jour
    for (var transaction in filteredTransactions) {
      final transactionDate = DateTime.parse(transaction.timestamp);
      final day = transactionDate.day;
      dailyTotals[day] = (dailyTotals[day] ?? 0) + transaction.amount;
    }

    // Créer les points pour le graphique
    return dailyTotals.entries
        .map((e) => FlSpot(e.key.toDouble(), e.value))
        .toList()
      ..sort((a, b) => a.x.compareTo(b.x));
  }

  // Calculer les statistiques
  Map<String, double> _calculateStats(List<Transaction> transactions) {
    final filteredTransactions = _getFilteredTransactions(transactions);

    double weeklySpend = 0;
    double shopping = 0;
    double others = 0;
    double income = 0;

    for (var transaction in filteredTransactions) {
      if (transaction.isIncoming) {
        income += transaction.amount;
      } else {
        weeklySpend += transaction.amount.abs();
        if (transaction.type == 'Shopping') {
          shopping += transaction.amount.abs();
        } else {
          others += transaction.amount.abs();
        }
      }
    }

    return {
      'weeklySpend': weeklySpend,
      'shopping': shopping,
      'others': others,
      'income': income,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wallets',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Implémenter l'ajout de transaction
            },
          ),
        ],
      ),
      body: Consumer<WalletProvider>(
        builder: (context, walletProvider, child) {
          final currentWallet = walletProvider.wallets[_selectedWalletIndex];
          final spots = _generateChartSpots(currentWallet.transactions);
          final stats = _calculateStats(currentWallet.transactions);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    itemCount: walletProvider.wallets.length,
                    controller: PageController(viewportFraction: 0.9),
                    onPageChanged: (index) {
                      setState(() => _selectedWalletIndex = index);
                    },
                    itemBuilder: (context, index) {
                      return WalletCard(
                        wallet: walletProvider.wallets[index],
                        isSelected: index == _selectedWalletIndex,
                        onTap: () {},
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total spending',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildTimeRangeButton('Day'),
                          _buildTimeRangeButton('Week'),
                          _buildTimeRangeButton('Month'),
                          _buildTimeRangeButton('Custom range'),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 200,
                        child: spots.isEmpty
                            ? const Center(
                                child: Text('No transactions for this period'))
                            : LineChart(
                                LineChartData(
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: spots,
                                      isCurved: true,
                                      barWidth: 3,
                                      color: Colors.blue,
                                      dotData: FlDotData(show: true),
                                    ),
                                  ],
                                  titlesData: FlTitlesData(
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 40,
                                      ),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 22,
                                      ),
                                    ),
                                  ),
                                  gridData: FlGridData(show: true),
                                  borderData: FlBorderData(show: true),
                                ),
                              ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildSpendingCategory(
                            'Weekly spend',
                            '\$${stats['weeklySpend']?.toStringAsFixed(2)}',
                            Colors.blue,
                          ),
                          _buildSpendingCategory(
                            'Shopping',
                            '\$${stats['shopping']?.toStringAsFixed(2)}',
                            Colors.orange,
                          ),
                          _buildSpendingCategory(
                            'Others',
                            '\$${stats['others']?.toStringAsFixed(2)}',
                            Colors.purple,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Weekly income',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            '\$${stats['income']?.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            // Implémenter la vue détaillée
                          },
                          child: const Text('See details'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeRangeButton(String label) {
    final isSelected = _selectedTimeRange == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTimeRange = label),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpendingCategory(String label, String amount, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
