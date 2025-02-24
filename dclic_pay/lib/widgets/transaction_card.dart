import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            'https://api.dicebear.com/7.x/avataaars/png?seed=${transaction.receiverName}',
          ),
        ),
        title: Text(
          transaction.receiverName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          DateFormat('dd MMM yyyy')
              .format(DateTime.parse(transaction.timestamp)),
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        trailing: Text(
          '${transaction.isIncoming ? "+" : "-"}\$${transaction.amount.toStringAsFixed(2)}',
          style: TextStyle(
            color: transaction.isIncoming ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
