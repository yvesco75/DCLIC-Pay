import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/transaction.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedFilter = 'All';
  final List<String> filters = [
    'All',
    'Income',
    'Expense',
    'Last 7 days',
    'Last 30 days'
  ];
  double currentBalance = 6190.00;
  List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();
    _loadData();
    _initializeTransactions();
  }

  void _initializeTransactions() {
    final List<Transaction> initialTransactions = [
      Transaction(
        id: "1",
        senderId: "sender1",
        receiverName: "Mradle",
        receiverId: "receiver1",
        amount: 1190.00,
        timestamp: "2025-01-22T22:42:00",
        type: "income",
        status: "completed",
        isIncoming: true,
      ),
      Transaction(
        id: "2",
        senderId: "sender2",
        receiverName: "Emeric",
        receiverId: "receiver2",
        amount: -575.00,
        timestamp: "2025-01-21T22:42:00",
        type: "expense",
        status: "completed",
        isIncoming: false,
      ),
      Transaction(
        id: "3",
        senderId: "sender3",
        receiverName: "Nelly",
        receiverId: "receiver3",
        amount: -5220.00,
        timestamp: "2025-01-20T22:42:00",
        type: "expense",
        status: "completed",
        isIncoming: false,
      ),
      Transaction(
        id: "4",
        senderId: "sender4",
        receiverName: "Silas",
        receiverId: "receiver4",
        amount: 52000.00,
        timestamp: "2025-01-19T22:42:00",
        type: "income",
        status: "completed",
        isIncoming: true,
      ),
      Transaction(
        id: "5",
        senderId: "sender5",
        receiverName: "Alice",
        receiverId: "receiver5",
        amount: 300.00,
        timestamp: "2025-01-18T14:30:00",
        type: "income",
        status: "completed",
        isIncoming: true,
      ),
      Transaction(
        id: "6",
        senderId: "sender6",
        receiverName: "Bob",
        receiverId: "receiver6",
        amount: -150.00,
        timestamp: "2025-01-17T09:15:00",
        type: "expense",
        status: "completed",
        isIncoming: false,
      ),
      Transaction(
        id: "7",
        senderId: "sender7",
        receiverName: "Charlie",
        receiverId: "receiver7",
        amount: -2000.00,
        timestamp: "2025-01-16T16:45:00",
        type: "expense",
        status: "completed",
        isIncoming: false,
      ),
      Transaction(
        id: "8",
        senderId: "sender8",
        receiverName: "Diana",
        receiverId: "receiver8",
        amount: 4500.00,
        timestamp: "2025-01-15T11:00:00",
        type: "income",
        status: "completed",
        isIncoming: true,
      ),
      Transaction(
        id: "9",
        senderId: "sender9",
        receiverName: "Eva",
        receiverId: "receiver9",
        amount: -750.00,
        timestamp: "2025-01-14T19:20:00",
        type: "expense",
        status: "completed",
        isIncoming: false,
      ),
      Transaction(
        id: "10",
        senderId: "sender10",
        receiverName: "Frank",
        receiverId: "receiver10",
        amount: 1200.00,
        timestamp: "2025-01-13T08:00:00",
        type: "income",
        status: "completed",
        isIncoming: true,
      ),
    ];

    setState(() {
      transactions = initialTransactions;
    });
  }

  Future<void> _loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        currentBalance = prefs.getDouble('balance') ?? 6190.00;

        final transactionsJson = prefs.getStringList('transactions') ?? [];
        if (transactionsJson.isNotEmpty) {
          transactions = transactionsJson.map((String transactionStr) {
            final Map<String, dynamic> transactionMap =
                jsonDecode(transactionStr);
            return Transaction.fromJson(transactionMap);
          }).toList();
        }
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  List<Transaction> _getFilteredTransactions() {
    switch (selectedFilter) {
      case 'Income':
        return transactions.where((t) => t.isIncoming).toList();
      case 'Expense':
        return transactions.where((t) => !t.isIncoming).toList();
      case 'Last 7 days':
        final lastWeek = DateTime.now().subtract(Duration(days: 7));
        return transactions.where((t) {
          final transactionDate = DateTime.parse(t.timestamp);
          return transactionDate.isAfter(lastWeek);
        }).toList();
      case 'Last 30 days':
        final lastMonth = DateTime.now().subtract(Duration(days: 30));
        return transactions.where((t) {
          final transactionDate = DateTime.parse(t.timestamp);
          return transactionDate.isAfter(lastMonth);
        }).toList();
      default:
        return transactions;
    }
  }

  String _getMonthName(int month) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthNames[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            AssetImage("assets/images/avatar_1.jpeg"),
                        backgroundColor: Colors.blue[100],
                        onBackgroundImageError: (exception, stackTrace) {
                          print('Error loading avatar image: $exception');
                        },
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Hello Sacof !",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[200],
                    child: IconButton(
                      icon: Icon(Icons.search, color: Colors.black87),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sacof account",
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          "Arian zesan",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        Text(
                          "\$${currentBalance.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Total balance",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Added card: 05",
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          "Ac. no. 2234521",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Features",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("See more"),
                  ),
                ],
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/send_money'),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.sync_alt, size: 20),
                            SizedBox(width: 5),
                            Text("Send"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.sync, size: 20),
                          SizedBox(width: 5),
                          Text("Receive"),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.visibility, size: 20),
                          SizedBox(width: 5),
                          Text("Rewards"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent activity",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  PopupMenuButton<String>(
                    initialValue: selectedFilter,
                    onSelected: (String value) {
                      setState(() {
                        selectedFilter = value;
                      });
                    },
                    itemBuilder: (BuildContext context) {
                      return filters.map((String filter) {
                        return PopupMenuItem<String>(
                          value: filter,
                          child: Text(filter),
                        );
                      }).toList();
                    },
                    child: Row(
                      children: [
                        Text(selectedFilter),
                        Icon(Icons.keyboard_arrow_down, size: 20),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _getFilteredTransactions().length,
                  itemBuilder: (context, index) {
                    final transaction = _getFilteredTransactions()[index];
                    final DateTime transactionDate =
                        DateTime.parse(transaction.timestamp);
                    final String formattedDate =
                        "${transactionDate.day} ${_getMonthName(transactionDate.month)} ${transactionDate.year}";
                    final String formattedTime =
                        "${transactionDate.hour.toString().padLeft(2, '0')}:${transactionDate.minute.toString().padLeft(2, '0')}";

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                            "assets/images/avatar_${(index % 6) + 1}.jpeg"),
                        backgroundColor: Colors.grey[200],
                        onBackgroundImageError: (exception, stackTrace) {
                          print('Error loading transaction avatar: $exception');
                        },
                      ),
                      title: Text(transaction.receiverName),
                      subtitle: Text(formattedDate),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${transaction.isIncoming ? '+' : '-'}\$${transaction.amount.abs().toStringAsFixed(2)}",
                            style: TextStyle(
                              color: transaction.isIncoming
                                  ? Colors.blue
                                  : Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            formattedTime,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
