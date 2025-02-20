import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import 'send_money_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserService _userService = UserService();
  User? _user;
  double _balance = 6190.00;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _user =
        await _userService.getCurrentUser(); // Utilisation de getCurrentUser()
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/user_avatar.png'),
            ),
            const SizedBox(width: 10),
            Text(
              _user != null
                  ? 'Hello ${_user!.fullName}!'
                  : 'Hello!', // Utilisation de fullName
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBalanceCard(),
            const SizedBox(height: 20),
            _buildFeaturesRow(context),
            _buildActionButtons(context),
            const Divider(),
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
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Sacof Account',
                    style: TextStyle(fontSize: 24, color: Colors.white)),
                Text(
                  _user?.fullName ?? 'Arian Zesan', // Utilisation de fullName
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Text(
                    '\$${_balance.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 32, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  const Text('Total balance',
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
          const Text(
            'Features',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
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
              width: 50,
              height: 30,
              padding: 1,
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
            imagePath: 'assets/images/3.png', // Assurez-vous que l'image existe
            text: "Rewards",
            width: 50,
            height: 30,
            padding: 1,
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
              const Text("Recent Activity",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButton(
                value: 'All',
                items: ['All', 'Sent', 'Received', 'Top-up']
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
  final double width;
  final double height;
  final double padding;

  const FeatureButton({
    Key? key,
    required this.imagePath,
    required this.text,
    this.width = 20,
    this.height = 10,
    this.padding = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
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
