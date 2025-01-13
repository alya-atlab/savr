import 'package:flutter/material.dart';
import 'api_services/saving.dart';

class UserSavingsScreen extends StatefulWidget {
  final int userId;

  const UserSavingsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _UserSavingsScreenState createState() => _UserSavingsScreenState();
}

class _UserSavingsScreenState extends State<UserSavingsScreen> {
  double totalMoneySaved = 0.0;
  int totalItemsSaved = 0;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchUserSavings();
  }

  Future<void> fetchUserSavings() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      final savings = await getUserSavings(widget.userId);

      setState(() {
        totalMoneySaved = double.parse(savings['total_money_saved'].toString());
        totalItemsSaved = int.parse(savings['total_items_saved'].toString());
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FFFD),
      appBar: AppBar(
        title: const Text('Your Savings'),
        backgroundColor: const Color(0xFF007E6C),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : errorMessage.isNotEmpty
                ? Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Good job food savior!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF007E6C),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.attach_money,
                              size: 50, color: Colors.green),
                          Text(
                            'You have saved \$${totalMoneySaved.toStringAsFixed(2)} till now!',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.restaurant_menu,
                              size: 50, color: Colors.orange),
                          Text(
                            'You saved $totalItemsSaved items from going to waste!',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF007E6C),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 32),
                        ),
                        onPressed: () {
                          // Add a share feature or another action if needed
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Sharing is not yet implemented!')),
                          );
                        },
                        child: const Text('Share with your friends'),
                      ),
                    ],
                  ),
      ),
    );
  }
}
