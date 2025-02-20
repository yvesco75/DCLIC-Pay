class BankCard {
  final String id;
  final String cardType;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;
  final double balance;
  final bool isPhysical; // Ajoutez cette propriété

  BankCard({
    required this.id,
    required this.cardType,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
    required this.balance,
    required this.isPhysical, // Ajoutez cette propriété
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cardType': cardType,
      'cardNumber': cardNumber,
      'cardHolderName': cardHolderName,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'balance': balance,
      'isPhysical': isPhysical, // Ajoutez cette propriété
    };
  }

  factory BankCard.fromMap(Map<String, dynamic> map) {
    return BankCard(
      id: map['id'],
      cardType: map['cardType'],
      cardNumber: map['cardNumber'],
      cardHolderName: map['cardHolderName'],
      expiryDate: map['expiryDate'],
      cvv: map['cvv'],
      balance: map['balance'].toDouble(),
      isPhysical: map['isPhysical'] ?? false, // Ajoutez cette propriété
    );
  }
}
