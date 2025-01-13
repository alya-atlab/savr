import 'package:flutter/material.dart';
import '../api_services/user_service.dart';

class Profile extends StatefulWidget {
  final int userId;
  const Profile({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String username = "";
  double totalSavings = 0.0;
  int totalItemsSaved = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final userData = await UserService.fetchUserData(widget.userId);

    if (userData['success']) {
      setState(() {
        username = userData['name'];
        totalSavings = userData['totalSavings'];
        totalItemsSaved = userData['totalItemsSaved'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(userData['message'] ?? 'Error fetching data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF0FFFD),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Transform.scale(
                          scale: 1.2,
                          child: Container(
                            height: 200,
                            decoration: const BoxDecoration(
                              color: Color(0xFF007E6C),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(500),
                                bottomRight: Radius.circular(500),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 150,
                          left: 0,
                          right: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xFF007E6C),
                                    width: 4.0,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    username.isNotEmpty
                                        ? username[0].toUpperCase()
                                        : '',
                                    style: const TextStyle(
                                      color: Color(0xFF007E6C),
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 70),
                    Text(
                      username,
                      style: const TextStyle(
                        color: Color(0xFF007E6C),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Good job food savior!',
                      style: TextStyle(
                        color: Color(0xFF007E6C),
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.attach_money,
                                  color: Color(0xFF007E6C)),
                              SizedBox(width: 5),
                              Text(
                                'You have saved:',
                                style: TextStyle(
                                  color: Color(0xFF007E6C),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '\$${totalSavings.toStringAsFixed(2)} till now',
                            style: const TextStyle(
                              color: Color(0xFF007E6C),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.fastfood, color: Color(0xFF007E6C)),
                              SizedBox(width: 5),
                              Text(
                                'You saved:',
                                style: TextStyle(
                                  color: Color(0xFF007E6C),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '$totalItemsSaved items from going to waste!',
                            style: const TextStyle(
                              color: Color(0xFF007E6C),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF007E6C),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        // Share functionality
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Share with your friend',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.share, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
  }
}
