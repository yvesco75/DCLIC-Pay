import 'transaction.dart'; // Importe la classe Transaction
import 'card.dart'; // Assurez-vous que l'importation est correcte

class User {
  final String name;
  final double totalBalance;
  final List<Transaction> transactions;
  final List<BankCard> cards; // Utilisez BankCard au lieu de Card

  User({
    required this.name,
    required this.totalBalance,
    required this.transactions,
    required this.cards,
  });
}
