import '../models/user.dart';

class UserService {
  User? _currentUser;

  UserService() {
    // Initialiser avec un utilisateur de test
    _currentUser = User(
      id: '1',
      fullName: 'John Doe',
      email: 'john.doe@example.com',
      phoneNumber: '+1234567890',
      avatar: 'assets/images/avatar_1.jpeg',
      balance: 5000.0,
      cardIds: ['1', '2'],
    );
  }

  Future<User?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _currentUser;
  }

  Future<void> updateUser(User user) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = user;
  }

  Future<void> updateBalance(double amount) async {
    if (_currentUser != null) {
      _currentUser!.balance += amount;
    }
  }

  Future<void> addCard(String cardId) async {
    if (_currentUser != null) {
      _currentUser!.cardIds.add(cardId);
    }
  }

  Future<void> removeCard(String cardId) async {
    if (_currentUser != null) {
      _currentUser!.cardIds.remove(cardId);
    }
  }
}
