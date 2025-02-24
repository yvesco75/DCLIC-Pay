import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart'; // Utilisation de flutter_credit_card
import '../models/wallet.dart';

class WalletCard extends StatelessWidget {
  final Wallet wallet;
  final bool isSelected;
  final VoidCallback onTap;

  const WalletCard({
    Key? key,
    required this.wallet,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: CreditCardWidget(
          cardNumber: wallet.cardNumber, // Numéro de carte
          expiryDate:
              '12/25', // Date d'expiration (à remplacer par la valeur réelle si disponible)
          cardHolderName: "Card Holder", // Nom du titulaire de la carte
          cvvCode:
              '123', // Code CVV (à remplacer par la valeur réelle si disponible)
          showBackView: false, // Afficher ou non le dos de la carte
          onCreditCardWidgetChange:
              (creditCardBrand) {}, // Callback pour les changements
          cardBgColor: isSelected
              ? Colors.blue
              : Colors.grey.shade800, // Couleur de fond de la carte
          isHolderNameVisible: true, // Afficher le nom du titulaire
          isChipVisible: true, // Afficher la puce
          isSwipeGestureEnabled: true, // Activer le geste de balayage
          backgroundImage: null, // Image de fond (optionnelle)
          customCardTypeIcons: const [], // Icônes personnalisées pour les types de carte
          cardType:
              CardType.mastercard, // Type de carte (mastercard en minuscules)
        ),
      ),
    );
  }
}
