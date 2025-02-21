import 'package:flutter/material.dart';
import 'package:u_credit_card/u_credit_card.dart';

class CreditCardWidget extends StatelessWidget {
  final bool isSelected;
  final bool isPhysical;
  final String cardHolderName; // Renommé pour plus de clarté
  final String cardNumber;
  final String expiry;

  const CreditCardWidget({
    Key? key,
    required this.isSelected,
    required this.isPhysical,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Action à réaliser lors de la sélection de la carte
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: CreditCardUi(
          cardHolderFullName: cardHolderName,
          cardNumber: cardNumber,
          validThru: expiry, // Assurez-vous que le format est correct (MM/YY)
          topLeftColor: Colors
              .black, // Couleur personnalisée pour le coin supérieur gauche
          bottomRightColor:
              Colors.grey, // Couleur personnalisée pour le coin inférieur droit
          showValidThru: true,
          cardType: isPhysical
              ? CardType.credit
              : CardType.debit, // Utilisez les types valides ici
        ),
      ),
    );
  }
}
