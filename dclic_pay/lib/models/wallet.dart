import 'package:flutter/foundation.dart';
import 'transaction.dart';

class Wallet {
  final String id;
  final String userId;
  double balance;
  final String cardNumber;
  final String cardType;
  final bool isVirtual;
  final DateTime expiryDate;
  final List<Transaction> transactions;

  static const double minimumBalance = 0.0;

  Wallet({
    required this.id,
    required this.userId,
    required this.balance,
    required this.cardNumber,
    required this.cardType,
    required this.isVirtual,
    required this.expiryDate,
    required this.transactions,
  });

  // Méthodes pour la gestion du solde
  bool hasSufficientBalance(double amount) {
    return balance >= amount;
  }

  bool canProcessTransaction(double amount) {
    return hasSufficientBalance(amount) && !isExpired;
  }

  void updateBalance(double amount, bool isCredit) {
    if (isCredit) {
      balance += amount;
    } else {
      if (!hasSufficientBalance(amount)) {
        throw Exception('Solde insuffisant');
      }
      balance -= amount;
    }
  }

  // Méthodes pour la gestion des transactions
  void addTransaction(Transaction transaction) {
    transactions.insert(0, transaction);
    updateBalance(transaction.amount, transaction.type == 'RECEIVE');
  }

  List<Transaction> getRecentTransactions([int limit = 10]) {
    return transactions.take(limit).toList();
  }

  double getTotalSpent() {
    return transactions
        .where((t) => t.type == 'SEND')
        .fold(0.0, (sum, tx) => sum + tx.amount);
  }

  double getTotalReceived() {
    return transactions
        .where((t) => t.type == 'RECEIVE')
        .fold(0.0, (sum, tx) => sum + tx.amount);
  }

  // Getters utiles
  bool get isExpired => expiryDate.isBefore(DateTime.now());

  String get maskedCardNumber {
    if (cardNumber.length < 4) return cardNumber;
    return '****${cardNumber.substring(cardNumber.length - 4)}';
  }

  // Copie de l'objet avec modifications
  Wallet copyWith({
    String? id,
    String? userId,
    double? balance,
    String? cardNumber,
    String? cardType,
    bool? isVirtual,
    DateTime? expiryDate,
    List<Transaction>? transactions,
  }) {
    return Wallet(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      balance: balance ?? this.balance,
      cardNumber: cardNumber ?? this.cardNumber,
      cardType: cardType ?? this.cardType,
      isVirtual: isVirtual ?? this.isVirtual,
      expiryDate: expiryDate ?? this.expiryDate,
      transactions: transactions ?? this.transactions,
    );
  }

  // Conversion en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'balance': balance,
      'cardNumber': cardNumber,
      'cardType': cardType,
      'isVirtual': isVirtual,
      'expiryDate': expiryDate.toIso8601String(),
      'transactions': transactions.map((tx) => tx.toJson()).toList(),
    };
  }

  // Création depuis JSON
  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json['id'] as String,
      userId: json['userId'] as String,
      balance: (json['balance'] as num).toDouble(),
      cardNumber: json['cardNumber'] as String,
      cardType: json['cardType'] as String,
      isVirtual: json['isVirtual'] as bool,
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      transactions: (json['transactions'] as List<dynamic>)
          .map((tx) => Transaction.fromJson(tx as Map<String, dynamic>))
          .toList(),
    );
  }

  // Création d'un wallet par défaut
  factory Wallet.defaultWallet(String userId) {
    return Wallet(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      balance: 0.0,
      cardNumber: '4111111111111111',
      cardType: 'VISA',
      isVirtual: false,
      expiryDate: DateTime.now().add(const Duration(days: 365 * 3)),
      transactions: [],
    );
  }

  @override
  String toString() {
    return 'Wallet{id: $id, userId: $userId, balance: $balance, cardType: $cardType, isVirtual: $isVirtual}';
  }
}
