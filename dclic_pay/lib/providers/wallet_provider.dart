import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/transaction.dart';
import '../models/wallet.dart';

class WalletProvider with ChangeNotifier {
  List<Wallet> _wallets = [];
  List<Transaction> _transactions = [];
  late SharedPreferences _prefs;
  double _defaultBalance = 6190.00; // Balance initiale par défaut

  // Getters
  List<Wallet> get wallets => _wallets;
  List<Transaction> get transactions => _transactions;

  // Initialisation
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    await _loadWallets();
    await _loadTransactions();
  }

  // Chargement des wallets
  Future<void> _loadWallets() async {
    final walletsJson = _prefs.getString('wallets') ?? '[]';
    final List<dynamic> decoded = jsonDecode(walletsJson);
    _wallets = decoded.map((w) => Wallet.fromJson(w)).toList();

    // Si aucun wallet n'existe, on en crée un par défaut
    if (_wallets.isEmpty) {
      _wallets.add(Wallet(
        id: '1',
        userId: '1',
        balance: _defaultBalance,
        cardNumber: '',
        cardType: '',
        isVirtual: false,
        expiryDate: DateTime.now(),
        transactions: [],
      ));
      await _saveWallets();
    }

    notifyListeners();
  }

  // Chargement des transactions
  Future<void> _loadTransactions() async {
    final transactionsJson = _prefs.getString('transactions') ?? '[]';
    final List<dynamic> decoded = jsonDecode(transactionsJson);
    _transactions = decoded.map((t) => Transaction.fromJson(t)).toList();
    notifyListeners();
  }

  // Ajout d'une transaction
  Future<void> addTransaction(Transaction transaction) async {
    _transactions.insert(0, transaction); // Ajoute au début de la liste
    await _updateWalletBalance(transaction);
    await _saveTransactions();
    notifyListeners();
  }

  // Mise à jour du solde du wallet
  Future<void> _updateWalletBalance(Transaction transaction) async {
    final wallet = _wallets.firstWhere((w) => w.userId == transaction.senderId);
    final newBalance = transaction.isIncoming
        ? wallet.balance + transaction.amount
        : wallet.balance - transaction.amount;

    final updatedWallet = wallet.copyWith(
      balance: newBalance,
      transactions: [...wallet.transactions, transaction],
    );

    final index = _wallets.indexWhere((w) => w.id == wallet.id);
    _wallets[index] = updatedWallet;
    await _saveWallets();
  }

  // Sauvegarde des wallets
  Future<void> _saveWallets() async {
    final walletsJson = jsonEncode(_wallets.map((w) => w.toJson()).toList());
    await _prefs.setString('wallets', walletsJson);
  }

  // Sauvegarde des transactions
  Future<void> _saveTransactions() async {
    final transactionsJson =
        jsonEncode(_transactions.map((t) => t.toJson()).toList());
    await _prefs.setString('transactions', transactionsJson);
  }

  // Vérifie si une transaction peut être effectuée
  Future<bool> canMakeTransaction(double amount) async {
    final wallet =
        _wallets.firstWhere((w) => w.userId == '1'); // Current user wallet
    return wallet.balance >= amount;
  }
}
