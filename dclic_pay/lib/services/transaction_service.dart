import '../models/transaction.dart';

class TransactionService {
  List<Transaction> getTransactions() {
    return [
      Transaction(
          description: 'Mirade',
          amount: 1190.00,
          date: DateTime(2025, 1, 23),
          isCredit: true),
      Transaction(
          description: 'Emeric',
          amount: 75.00,
          date: DateTime(2025, 1, 21),
          isCredit: false),
      Transaction(
          description: 'Nelly',
          amount: 220.00,
          date: DateTime(2025, 6, 20),
          isCredit: false),
      Transaction(
          description: 'Silas',
          amount: 2000.00,
          date: DateTime(2025, 1, 19),
          isCredit: true),
    ];
  }
}
