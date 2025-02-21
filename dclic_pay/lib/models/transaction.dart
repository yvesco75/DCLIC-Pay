class Transaction {
  final String id;
  final String type; // 'income' ou 'expense'
  final double amount;
  final DateTime date;
  final String description;
  final String? category;

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
    required this.description,
    this.category,
  });

  // Getter pour déterminer si la transaction est un crédit
  bool get isCredit => type == 'income';

  // Convertir un objet Transaction en Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'date': date.toIso8601String(),
      'description': description,
      'category': category,
    };
  }

  // Créer une Transaction à partir d'une Map
  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      type: map['type'],
      amount: map['amount'].toDouble(),
      date: DateTime.parse(map['date']),
      description: map['description'],
      category: map['category'],
    );
  }

  // Pour la rétrocompatibilité
  Map<String, dynamic> toJson() => toMap();
  static Transaction fromJson(Map<String, dynamic> json) =>
      Transaction.fromMap(json);
}
