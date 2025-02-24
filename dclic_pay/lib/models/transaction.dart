class Transaction {
  final String id;
  final String senderId;
  final String receiverName;
  final String receiverId;
  final double amount;
  final String timestamp;
  final String type;
  final String status;
  final bool isIncoming;

  Transaction({
    required this.id,
    required this.senderId,
    required this.receiverName,
    required this.receiverId,
    required this.amount,
    required this.timestamp,
    required this.type,
    required this.status,
    required this.isIncoming,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      senderId: json['senderId'],
      receiverName: json['receiverName'],
      receiverId: json['receiverId'],
      amount: json['amount'].toDouble(),
      timestamp: json['timestamp'],
      type: json['type'],
      status: json['status'],
      isIncoming: json['isIncoming'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverName': receiverName,
      'receiverId': receiverId,
      'amount': amount,
      'timestamp': timestamp,
      'type': type,
      'status': status,
      'isIncoming': isIncoming,
    };
  }
}
