class User {
  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String? avatar;
  double balance;
  List<String> cardIds;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.avatar,
    this.balance = 0.0,
    this.cardIds = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'avatar': avatar,
      'balance': balance,
      'cardIds': cardIds,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      fullName: map['fullName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      avatar: map['avatar'],
      balance: map['balance']?.toDouble() ?? 0.0,
      cardIds: List<String>.from(map['cardIds'] ?? []),
    );
  }
}
