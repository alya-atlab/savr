import 'package:flutter/material.dart';
import 'signup.dart';
import 'signin.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _State();
}

class _State extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FFFD),
      body: Align(
        alignment: Alignment(0.0, -0.75),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('imgs/logo.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'discover fresh savings \n reduce food waste',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF007E6C),
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 100,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => signUp()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF007E6C),
                  padding: EdgeInsets.symmetric(horizontal: 75, vertical: 15),
                ),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Color(0xFF007E6C),
                      fontSize: 15,

                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF007E6C),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,

                    ),
                  ),
                ),
              ],
            )

            // Add more widgets here if required
          ],
        ),
      ),
    );
  }
}
