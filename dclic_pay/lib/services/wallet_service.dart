import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Pour jsonEncode et jsonDecode
import '../models/transaction.dart'; // Importe Transaction

class WalletService {
  // Clés pour SharedPreferences
  static const String _transactionsKey = 'transactions';
  static const String _physicalCardBalanceKey = 'physicalCardBalance';
  static const String _virtualCardBalanceKey = 'virtualCardBalance';

  late SharedPreferences _prefs;

  // Initialiser SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Sauvegarder les transactions
  Future<void> saveTransactions(List<Transaction> transactions) async {
    final transactionsJson = transactions
        .map((transaction) => jsonEncode(transaction.toJson()))
        .toList();
    await _prefs.setStringList(_transactionsKey, transactionsJson);
  }

  // Charger les transactions
  Future<List<Transaction>> loadTransactions() async {
    final transactionsJson = _prefs.getStringList(_transactionsKey) ?? [];
    return transactionsJson
        .map((json) => Transaction.fromJson(jsonDecode(json)))
        .toList();
  }

  // Sauvegarder le solde de la carte physique
  Future<void> savePhysicalCardBalance(double balance) async {
    await _prefs.setDouble(_physicalCardBalanceKey, balance);
  }

  // Charger le solde de la carte physique
  Future<double> loadPhysicalCardBalance() async {
    return _prefs.getDouble(_physicalCardBalanceKey) ??
        2960.00; // Valeur par défaut
  }

  // Sauvegarder le solde de la carte virtuelle
  Future<void> saveVirtualCardBalance(double balance) async {
    await _prefs.setDouble(_virtualCardBalanceKey, balance);
  }

  // Charger le solde de la carte virtuelle
  Future<double> loadVirtualCardBalance() async {
    return _prefs.getDouble(_virtualCardBalanceKey) ??
        1280.00; // Valeur par défaut
  }
}
