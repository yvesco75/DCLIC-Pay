// services/card_service.dart
import '../models/card.dart'; // Assurez-vous que la classe BankCard est importée

class CardService {
  final List<BankCard> _cards = [];

  CardService() {
    // Ajouter quelques cartes par défaut
    _cards.addAll([
      BankCard(
        id: '1',
        cardType: 'Visa',
        cardNumber: '**** **** **** 1234',
        cardHolderName: 'John Doe',
        expiryDate: '12/25',
        cvv: '123',
        balance: 1500.0,
        isPhysical: true,
      ),
      BankCard(
        id: '2',
        cardType: 'Mastercard',
        cardNumber: '**** **** **** 5678',
        cardHolderName: 'John Doe',
        expiryDate: '06/24',
        cvv: '456',
        balance: 2500.0,
        isPhysical: false,
      ),
    ]);
  }

  // Obtenir toutes les cartes
  Future<List<BankCard>> getCards() async {
    await Future.delayed(
        const Duration(milliseconds: 500)); // Simuler un délai réseau
    return _cards;
  }

  // Ajouter une carte
  Future<void> addCard(BankCard card) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _cards.add(card);
  }

  // Mettre à jour une carte
  Future<void> updateCard(BankCard card) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _cards.indexWhere((c) => c.id == card.id);
    if (index != -1) {
      _cards[index] = card;
    }
  }

  // Supprimer une carte
  Future<void> deleteCard(String cardId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _cards.removeWhere((card) => card.id == cardId);
  }
}
