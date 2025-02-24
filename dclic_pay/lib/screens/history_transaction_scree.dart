import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../providers/wallet_provider.dart';
import 'package:provider/provider.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);
    final transactions = walletProvider.transactions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique des transactions'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  transaction.isIncoming ? Colors.green : Colors.red,
              child: Icon(
                transaction.isIncoming
                    ? Icons.arrow_downward
                    : Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
            title: Text(transaction.receiverName),
            subtitle: Text(transaction.timestamp),
            trailing: Text(
              "${transaction.isIncoming ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}",
              style: TextStyle(
                color: transaction.isIncoming ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
