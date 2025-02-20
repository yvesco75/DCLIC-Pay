import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/card_service.dart'; // Importez CardService
import '../services/transaction_service.dart';
import '../models/card.dart' as my_card; // Alias pour éviter le conflit
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int selectedCardIndex = 0;
  String selectedTimeRange = 'Week';
  List<my_card.BankCard> cards = []; // Utilisation de BankCard avec l'alias
  List<Transaction> transactions = [];
  final CardService _cardService = CardService(); // Utilisation de CardService
  final TransactionService _transactionService = TransactionService();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    cards = await _cardService.getCards(); // Assignation correcte
    transactions = await _transactionService.getTransactions();
    setState(() {});
  }

  double get totalBalance {
    return cards.fold(
        0.0, (double sum, my_card.BankCard card) => sum + card.balance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Wallets',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add, color: Colors.blue),
                      onPressed: () {
                        // Logique pour ajouter une carte
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Cards Section
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: _buildCard(
                        index: index,
                        card: cards[index],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Total Spending Section
              const Text(
                'Total spending',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Time Range Selector
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTimeRangeButton('Week', true),
                    _buildTimeRangeButton('Month', false),
                    _buildTimeRangeButton('Custom range', false),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Graph Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                getTitlesWidget: (value, meta) {
                                  return Text('\$${value.toInt()}',
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12));
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  const days = [
                                    'Mon',
                                    'Tue',
                                    'Wed',
                                    'Thu',
                                    'Fri',
                                    'Sat',
                                    'Sun'
                                  ];
                                  if (value.toInt() < days.length) {
                                    return Text(days[value.toInt()],
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12));
                                  }
                                  return const Text('');
                                },
                              ),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: [
                                const FlSpot(0, 200),
                                const FlSpot(1, 150),
                                const FlSpot(2, 250),
                                const FlSpot(3, 300),
                                const FlSpot(4, 250),
                                const FlSpot(5, 200),
                                const FlSpot(6, 150),
                              ],
                              isCurved: true,
                              color: Colors.blue,
                              barWidth: 3,
                              dotData: FlDotData(show: false),
                              belowBarData: BarAreaData(
                                show: true,
                                color: Colors.blue.withOpacity(0.1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSpendingRow('Weekly spend', '\$1,454.00'),
                    _buildSpendingRow('Shopping', '\$890.00'),
                    _buildSpendingRow('Others', '\$564.00'),
                    const Divider(),
                    _buildSpendingRow('Weekly income', '\$2,960.00',
                        showSeeDetails: true),
                  ],
                ),
              ),

              // Display Total Balance
              Text('Total Balance: \$${totalBalance.toStringAsFixed(2)}'),

              // Transaction History
              const Text(
                'Transaction History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 200, // Ajustez la hauteur selon vos besoins
                child: ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    return ListTile(
                      title: Text(transaction.description),
                      subtitle: Text(
                        DateFormat('yyyy-MM-dd – kk:mm')
                            .format(transaction.date),
                      ),
                      trailing:
                          Text('\$${transaction.amount.toStringAsFixed(2)}'),
                    );
                  },
                ),
              ),
              // Send Money Button
              ElevatedButton(
                onPressed: () {
                  // Naviguer vers l'écran d'envoi d'argent
                },
                child: const Text('Send Money'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required int index,
    required my_card.BankCard card, // Utilisation de BankCard avec l'alias
  }) {
    bool isSelected = selectedCardIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedCardIndex = index),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  card.isPhysical
                      ? Icons.credit_card
                      : Icons.credit_card_outlined,
                  color: isSelected ? Colors.white : Colors.black,
                ),
                const SizedBox(width: 8),
                Text(
                  card.cardType,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '\$${card.balance.toStringAsFixed(2)}',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[700],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeRangeButton(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTimeRange = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.blue,
          ),
        ),
      ),
    );
  }

  Widget _buildSpendingRow(String label, String amount,
      {bool showSeeDetails = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(amount),
        if (showSeeDetails)
          TextButton(
            onPressed: () {
              // Logique pour voir les détails
            },
            child: const Text('See details'),
          ),
      ],
    );
  }
}
