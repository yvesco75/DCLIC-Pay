import '../models/user.dart';
import 'transaction_service.dart';
import 'card_service.dart';

class UserService {
  User getUser() {
    return User(
      name: 'Saco',
      totalBalance: 6190.00,
      transactions: TransactionService().getTransactions(),
      cards: CardService().getCards(),
    );
  }
}
