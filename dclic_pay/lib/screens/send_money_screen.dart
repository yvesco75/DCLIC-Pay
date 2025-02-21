import 'package:flutter/material.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({Key? key}) : super(key: key);

  @override
  _SendMoneyScreenState createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  String selectedCard = 'Physical debit card';
  bool termsAccepted = false;
  final TextEditingController amountController =
      TextEditingController(text: "75.00");
  final TextEditingController searchController = TextEditingController();
  final TextEditingController recipientController = TextEditingController();

  final List<Map<String, dynamic>> recipients = [
    {
      "name": "Sarah",
      "avatar": "assets/images/sarah.png",
      "color": Colors.purple[50],
    },
    {
      "name": "Tommy",
      "avatar": "assets/images/tommy.png",
      "color": Colors.pink[50],
    },
    {
      "name": "Robert",
      "avatar": "assets/images/robert.png",
      "color": Colors.blue[50],
    },
    {
      "name": "Mike",
      "avatar": "assets/images/mike.png",
      "color": Colors.orange[50],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue[100],
                          child:
                              const Text('👨', style: TextStyle(fontSize: 20)),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Hello Sacof!',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.blue[50],
                      child: IconButton(
                        icon: const Icon(Icons.lock, color: Colors.blue),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Title
                const Center(
                  child: Text(
                    'Send money',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Select Card Section
                const Text(
                  'Select card',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCardChip(
                        'Physical debit card',
                        'MC',
                        isSelected: selectedCard == 'Physical debit card',
                        onTap: () => setState(
                            () => selectedCard = 'Physical debit card'),
                      ),
                      const SizedBox(width: 8),
                      _buildCardChip(
                        'Virtual debit card',
                        'VISA',
                        isSelected: selectedCard == 'Virtual debit card',
                        onTap: () =>
                            setState(() => selectedCard = 'Virtual debit card'),
                      ),
                      const SizedBox(width: 8),
                      _buildCardChip(
                        'Ebt',
                        'EBT',
                        isSelected: selectedCard == 'Ebt',
                        onTap: () => setState(() => selectedCard = 'Ebt'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Choose Recipient Section
                const Text(
                  'Choose recipient',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: recipientController,
                  decoration: InputDecoration(
                    hintText: 'Type name/card/phone number/email',
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                    suffixIcon: Icon(Icons.lock, color: Colors.blue, size: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[200]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[200]!),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                  ),
                ),

                const SizedBox(height: 16),

                // Recipients List
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recipients.length,
                    itemBuilder: (context, index) {
                      final recipient = recipients[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: recipient["color"],
                              backgroundImage: AssetImage(recipient["avatar"]),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              recipient["name"],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Amount Section
                const Text(
                  'Amount',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Column(
                    children: [
                      Text(
                        '\$${amountController.text}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          7,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            width: 2,
                            height: 12,
                            color: Colors.blue[200],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Terms and Send Button
                Row(
                  children: [
                    Transform.scale(
                      scale: 0.9,
                      child: Checkbox(
                        value: termsAccepted,
                        onChanged: (value) {
                          setState(() {
                            termsAccepted = value ?? false;
                          });
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Agree with ideate\'s terms and conditions',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: termsAccepted ? _sendMoney : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBackgroundColor: Colors.grey[300],
                    ),
                    child: const Text(
                      'Send money',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardChip(String title, String cardType,
      {required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color:
                    isSelected ? Colors.white.withOpacity(0.2) : Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                cardType,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[700],
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMoney() {
    if (!termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept the terms and conditions')),
      );
      return;
    }

    final amount = double.tryParse(amountController.text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    // Simulate sending money
    setState(() {
      // Update state or show loading indicator
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('Successfully sent \$${amount.toStringAsFixed(2)}')),
    );
  }
}
