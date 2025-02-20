import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import 'send_money_screen.dart';

class HomeScreen extends StatelessWidget {
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    User user = _userService.getUser();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/user_avatar.png'),
            ),
            SizedBox(width: 10),
            Text('Hello Sacof!', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(LucideIcons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBalanceCard(),
            SizedBox(height: 20),
            _buildFeaturesRow(context),
            _buildActionButtons(context),
            Divider(),
            _buildRecentActivity(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(228, 13, 74, 241),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(0, 3),
            )
          ],
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sacof Account',
                    style: TextStyle(fontSize: 24, color: Colors.white)),
                Text('Arian Zesan',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Text('\$6,190.00',
                      style: TextStyle(fontSize: 32, color: Colors.white)),
                  SizedBox(height: 8),
                  Text('Total balance',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Features',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'See More',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SendMoneyScreen()),
              );
            },
            child: FeatureButton(
              imagePath: 'assets/images/1.png',
              text: "Send",
              width: 50, // Taille personnalisée
              height: 30,
              padding: 1, // Padding personnalisé
            ),
          ),
          FeatureButton(
            imagePath: 'assets/images/2.png',
            text: "Receive",
            width: 50,
            height: 30,
            padding: 1,
          ),
          FeatureButton(
            imagePath: 'assets/images/1.png',
            text: "Rewards",
            width: 50,
            height: 20,
            padding: 0,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Recent Activity",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                value: 'All',
                items: <String>['All', 'Sent', 'Received', 'Top-up']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // Handle dropdown value change
                },
              ),
            ],
          ),
        ),
        ActivityTile(
          avatarUrl: "https://randomuser.me/api/portraits/men/10.jpg",
          name: "John Doe",
          date: "Feb 19, 2024",
          amount: "-\$50.00",
          time: "12:30 PM",
          isPositive: false,
        ),
        ActivityTile(
          avatarUrl: "https://randomuser.me/api/portraits/women/12.jpg",
          name: "Jane Smith",
          date: "Feb 18, 2024",
          amount: "+\$150.00",
          time: "4:45 PM",
          isPositive: true,
        ),
        ActivityTile(
          avatarUrl: "https://randomuser.me/api/portraits/men/15.jpg",
          name: "Mark Johnson",
          date: "Feb 17, 2024",
          amount: "-\$75.99",
          time: "8:10 AM",
          isPositive: false,
        ),
        ActivityTile(
          avatarUrl: "https://randomuser.me/api/portraits/women/20.jpg",
          name: "Emily Davis",
          date: "Feb 16, 2024",
          amount: "+\$200.00",
          time: "5:50 PM",
          isPositive: true,
        ),
      ],
    );
  }
}

class FeatureButton extends StatelessWidget {
  final String imagePath;
  final String text;
  final double width; // Nouveau paramètre pour la largeur du cadre
  final double height; // Nouveau paramètre pour la hauteur du cadre
  final double padding; // Nouveau paramètre pour le padding interne

  const FeatureButton({
    Key? key,
    required this.imagePath,
    required this.text,
    this.width = 20, // Valeur par défaut
    this.height = 10, // Valeur par défaut
    this.padding = 2, // Valeur par défaut
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: width, // Utilisation de la largeur définie
          height: height, // Utilisation de la hauteur définie
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.all(padding), // Utilisation du padding défini
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain, // Redimensionne l'image sans la rogner
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}

class ActivityTile extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String date;
  final String amount;
  final String time;
  final bool isPositive;

  const ActivityTile({
    Key? key,
    required this.avatarUrl,
    required this.name,
    required this.date,
    required this.amount,
    required this.time,
    required this.isPositive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(avatarUrl),
      ),
      title: Text(name),
      subtitle: Text(date),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            amount,
            style: TextStyle(color: isPositive ? Colors.green : Colors.red),
          ),
          Text(time),
        ],
      ),
    );
  }
}
