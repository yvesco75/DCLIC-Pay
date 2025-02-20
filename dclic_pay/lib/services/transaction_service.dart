import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionService {
  final List<Transaction> _transactions = [];

  TransactionService() {
    // Ajouter quelques transactions de test
    _addInitialTransactions();
  }

  void _addInitialTransactions() {
    _transactions.addAll([
      Transaction(
        id: '1',
        type: 'income',
        amount: 1000.0,
        date: DateTime.now().subtract(const Duration(days: 1)),
        description: 'Salaire',
        category: 'Revenus',
      ),
      Transaction(
        id: '2',
        type: 'expense',
        amount: 50.0,
        date: DateTime.now(),
        description: 'Restaurant',
        category: 'Alimentation',
      ),
    ]);
  }

  // Obtenir toutes les transactions
  Future<List<Transaction>> getTransactions() async {
    await Future.delayed(
        const Duration(milliseconds: 500)); // Simuler un délai réseau
    return _transactions;
  }

  // Ajouter une nouvelle transaction
  Future<void> addTransaction(Transaction transaction) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _transactions.add(transaction);
  }

  // Obtenir les transactions par type
  Future<List<Transaction>> getTransactionsByType(String type) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _transactions.where((t) => t.type == type).toList();
  }

  // Obtenir les transactions par période
  Future<List<Transaction>> getTransactionsByPeriod(String period) async {
    final now = DateTime.now();
    DateTime startDate;

    switch (period.toLowerCase()) {
      case 'week':
        startDate = now.subtract(const Duration(days: 7));
        break;
      case 'month':
        startDate = DateTime(now.year, now.month, 1);
        break;
      default:
        startDate = now.subtract(const Duration(days: 30));
    }

    return _transactions.where((t) => t.date.isAfter(startDate)).toList();
  }

  // Calculer le total des dépenses pour une période
  Future<double> getTotalSpending(String period) async {
    final transactions = await getTransactionsByPeriod(period);
    return transactions
        .where((t) => t.type == 'expense')
        .fold(0.0, (double sum, t) => sum + t.amount); // Correction ici
  }

  // Obtenir les dépenses par catégorie
  Future<Map<String, double>> getSpendingByCategory(String period) async {
    final transactions = await getTransactionsByPeriod(period);
    final Map<String, double> categoryTotals = {};

    for (var transaction in transactions) {
      if (transaction.type == 'expense' && transaction.category != null) {
        categoryTotals[transaction.category!] =
            (categoryTotals[transaction.category!] ?? 0.0) + transaction.amount;
      }
    }

    return categoryTotals;
  }

  // Formater le montant en devise
  String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(symbol: '\$');
    return formatter.format(amount);
  }
}
