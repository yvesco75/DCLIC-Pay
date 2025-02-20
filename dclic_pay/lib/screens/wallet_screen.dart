import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int selectedCardIndex = 0;
  String selectedTimeRange = 'Week';

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
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Cards Section
              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCard(
                      index: 0,
                      isPhysical: true,
                      cardType: 'Physical debit card',
                      balance: 2960.00,
                      cardNumber: '**** **** **** 4826',
                      expiry: '12/26',
                    ),
                    const SizedBox(width: 16),
                    _buildCard(
                      index: 1,
                      isPhysical: false,
                      cardType: 'Virtual debit card',
                      balance: 1280.00,
                      cardNumber: '**** **** **** 6399',
                      expiry: '07/27',
                    ),
                  ],
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required int index,
    required bool isPhysical,
    required String cardType,
    required double balance,
    required String cardNumber,
    required String expiry,
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
                  isPhysical ? Icons.credit_card : Icons.credit_card_outlined,
                  color: isSelected ? Colors.white : Colors.black,
                ),
                const SizedBox(width: 8),
                Text(
                  cardType,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              cardNumber,
              style: TextStyle(
                color: isSelected ? Colors.white70 : Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Exp: $expiry',
              style: TextStyle(
                color: isSelected ? Colors.white70 : Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${balance.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeRangeButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => selectedTimeRange = text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selectedTimeRange == text ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: selectedTimeRange == text
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  )
                ]
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selectedTimeRange == text ? Colors.blue : Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildSpendingRow(String label, String amount,
      {bool showSeeDetails = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              )),
          Row(
            children: [
              Text(amount,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
              if (showSeeDetails) ...[
                const SizedBox(width: 8),
                Text('See details',
                    style: TextStyle(
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w500,
                    )),
              ]
            ],
          ),
        ],
      ),
    );
  }
}
