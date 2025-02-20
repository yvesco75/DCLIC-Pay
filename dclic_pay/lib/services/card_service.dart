import '../models/card.dart';

class CardService {
  List<BankCard> getCards() {
    return [
      BankCard(
          cardNumber: 'Ac_no_2234.621', type: 'Physical', balance: 2960.00),
      BankCard(cardNumber: 'Ac_no_2234.622', type: 'Virtual', balance: 1280.00),
    ];
  }
}
