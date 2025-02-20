import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  TransactionItem({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(transaction.description),
      subtitle: Text('${transaction.date.toLocal()}'),
      trailing: Text(
        '\$${transaction.amount.toStringAsFixed(2)}',
        style: TextStyle(
          color: transaction.isCredit ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
