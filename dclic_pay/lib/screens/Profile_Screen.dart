import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart';
import '../screens/history_transaction_scree.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Profil'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Photo de profil
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(
                  "images/avatar_1.jpeg"), // Remplacez par votre image locale
              onBackgroundImageError: (_, __) {},
              backgroundColor: Colors.blue[100],
            ),
            SizedBox(height: 20),

            // Nom de l'utilisateur
            Text(
              "Sacof",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            // Email de l'utilisateur
            Text(
              "sacof@example.com",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 30),

            // Section des informations personnelles
            _buildProfileSection(
              title: "Informations personnelles",
              children: [
                _buildProfileItem(
                  icon: Icons.person,
                  label: "Nom complet",
                  value: "Sacof",
                ),
                _buildProfileItem(
                  icon: Icons.phone,
                  label: "Téléphone",
                  value: "+123 456 789",
                ),
                _buildProfileItem(
                  icon: Icons.location_on,
                  label: "Adresse",
                  value: "123 Rue de l'Exemple, Ville",
                ),
              ],
            ),
            SizedBox(height: 30),

            // Section des paramètres
            _buildProfileSection(
              title: "Paramètres",
              children: [
                _buildProfileItem(
                  icon: Icons.edit,
                  label: "Modifier le profil",
                  onTap: () {
                    // Action pour modifier le profil
                    print("Modifier le profil");
                  },
                ),
                _buildProfileItem(
                  icon: Icons.lock,
                  label: "Changer le mot de passe",
                  onTap: () {
                    // Action pour changer le mot de passe
                    print("Changer le mot de passe");
                  },
                ),
                _buildProfileItem(
                  icon: Icons.notifications,
                  label: "Notifications",
                  onTap: () {
                    // Action pour gérer les notifications
                    print("Gérer les notifications");
                  },
                ),
                // Ajout de l'onglet Historique des transactions
                _buildProfileItem(
                  icon: Icons.history,
                  label: "Historique des transactions",
                  onTap: () {
                    // Redirection vers la page d'historique des transactions
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TransactionHistoryScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 30),

            // Bouton de déconnexion
            ElevatedButton(
              onPressed: () async {
                // Déconnexion et redirection vers la page de login
                await authProvider.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "Déconnexion",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Méthode pour construire une section du profil
  Widget _buildProfileSection(
      {required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        ...children,
      ],
    );
  }

  // Méthode pour construire un élément du profil
  Widget _buildProfileItem({
    required IconData icon,
    required String label,
    String? value,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(label),
      subtitle: value != null ? Text(value) : null,
      trailing: onTap != null ? Icon(Icons.arrow_forward_ios, size: 16) : null,
      onTap: onTap,
    );
  }
}
