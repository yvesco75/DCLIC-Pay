import 'package:flutter/material.dart';
import '../models/card.dart';

class CardItem extends StatelessWidget {
  final BankCard card;

  CardItem({required this.card});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${card.type} Card'),
      subtitle: Text('Balance: \$${card.balance.toStringAsFixed(2)}'),
      trailing: Text(card.cardNumber),
    );
  }
}
