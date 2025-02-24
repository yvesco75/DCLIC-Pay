import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  late SharedPreferences _prefs;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final userJson = _prefs.getString('user');
    if (userJson != null) {
      _currentUser = User.fromJson(jsonDecode(userJson));
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simuler une attente d'API
      await Future.delayed(const Duration(seconds: 2));

      // Récupérer les informations d'inscription depuis SharedPreferences
      final savedEmail = _prefs.getString('savedEmail');
      final savedPassword = _prefs.getString('savedPassword');

      // Vérifier si les identifiants correspondent
      if (email == savedEmail && password == savedPassword) {
        _currentUser = User(
          id: '1',
          name: 'Sacof', // Vous pouvez stocker le nom lors de l'inscription
          email: email,
          imageUrl: 'https://api.dicebear.com/7.x/avataaars/png?seed=Sacof',
        );

        await _prefs.setString('user', jsonEncode(_currentUser!.toJson()));
        _isLoading = false;
        notifyListeners();
        return true;
      }

      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simuler une attente d'API
      await Future.delayed(const Duration(seconds: 2));

      // Enregistrer les informations d'inscription dans SharedPreferences
      await _prefs.setString('savedEmail', email);
      await _prefs.setString('savedPassword', password);

      // Créer un nouvel utilisateur
      _currentUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        imageUrl: 'https://api.dicebear.com/7.x/avataaars/png?seed=$name',
      );

      // Sauvegarder l'utilisateur dans SharedPreferences
      await _prefs.setString('user', jsonEncode(_currentUser!.toJson()));

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _prefs.remove('user');
    _currentUser = null;
    notifyListeners();
  }
}
