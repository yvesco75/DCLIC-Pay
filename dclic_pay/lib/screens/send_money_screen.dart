import 'package:flutter/material.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({Key? key}) : super(key: key);

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  String selectedCard = 'Physical debit card';
  bool termsAccepted = false;
  final TextEditingController amountController =
      TextEditingController(text: "75.00");

  // Liste des destinataires avec des images optionnelles
  final List<Map<String, dynamic>> recipients = [
    {"name": "Miradie", "color": Colors.purple, "image": null},
    {
      "name": "Emeric",
      "color": Colors.orange,
      "image": "assets/images/emeric.png"
    },
    {"name": "Nelly", "color": Colors.pink, "image": "assets/images/nelly.png"},
    {"name": "Eben Ezer", "color": Colors.green, "image": null},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                        const CircleAvatar(
                          backgroundColor: Colors.blue,
                          child:
                              Text('S', style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(width: 8),
                        const Text('Hello Sacof !',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    const Icon(Icons.search),
                  ],
                ),
                const SizedBox(height: 24),

                // Title
                const Center(
                  child: Text(
                    'Send Money',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Select card section
                const Text(
                  'Select Card',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCardOption(
                          'Physical debit card', 'mastercard', true),
                      _buildCardOption('Virtual debit card', 'visa', false),
                      _buildCardOption('ECB', 'ecb', false),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Choose recipient section
                const Text(
                  'Choose Recipient',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Type name/telephone number here',
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                    suffixIcon:
                        const Icon(Icons.help_outline, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Recipients list
                SizedBox(
                  height:
                      100, // Hauteur augmentée pour mieux afficher les images
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recipients.length,
                    itemBuilder: (context, index) {
                      final recipient = recipients[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 16), // Espacement horizontal
                        child: Column(
                          children: [
                            // Affichage de l'image si elle existe, sinon afficher un cercle avec l'initiale
                            if (recipient["image"] != null)
                              CircleAvatar(
                                backgroundImage: AssetImage(recipient["image"]),
                                radius: 30, // Taille de l'image du profil
                              )
                            else
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: recipient["color"],
                                child: Text(
                                  recipient["name"][0],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            const SizedBox(height: 8), // Espacement vertical
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

                // Amount section
                const Text(
                  'Amount',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
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
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 2,
                            height: 16,
                            color: Colors.blue[200],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Terms and Send button
                Row(
                  children: [
                    Checkbox(
                      value: termsAccepted,
                      onChanged: (value) {
                        setState(() {
                          termsAccepted = value!;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                        'Agree with User\'s terms and conditions',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: termsAccepted
                        ? () {
                            // Logique pour envoyer de l'argent
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Sending \$${amountController.text}...')),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[200], // Couleur plus claire
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Send Money',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
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

  Widget _buildCardOption(String title, String cardType, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCard = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedCard == title ? Colors.blue : Colors.grey[300]!,
          ),
          borderRadius: BorderRadius.circular(12),
          color: selectedCard == title ? Colors.blue : Colors.white,
        ),
        child: Row(
          children: [
            Icon(
              cardType == 'mastercard'
                  ? Icons.credit_card
                  : cardType == 'visa'
                      ? Icons.credit_card_outlined
                      : Icons.account_balance,
              color: selectedCard == title ? Colors.white : Colors.grey,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: selectedCard == title ? Colors.white : Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
