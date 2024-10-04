import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:tedxwordle/constants.dart';
import 'package:tedxwordle/screens/wordle_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController snuNetIdController = TextEditingController();
  final logger = Logger();
  final GoogleSignIn googleSignIn =
      GoogleSignIn(clientId: clientId); // Use a single instance

  @override
  void dispose() {
    nameController.dispose();
    snuNetIdController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn(BuildContext context) async {
    try {
      // Trigger the Google sign-in flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        logger.w('User canceled the sign-in');
        return; // The user canceled the sign-in
      }

      // Retrieve Google authentication credentials
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Check if the user has a valid email domain
      if (!googleUser.email.endsWith('@snu.edu.in')) {
        logger.e('User does not have a valid SNU email: ${googleUser.email}');
        await googleSignIn.signOut(); // Sign out to clear the session
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please login with a valid snu.edu.in email'),
          ),
        );
        return; // Stop further processing
      }

      // Proceed to Firebase authentication if the email is valid
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase using the Google credentials
      final UserCredential authRes =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Check if the user has successfully signed in
      if (authRes.user != null) {
        logger.i('User logged in with SNU Net ID');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WordleScreen()),
        );
      } else {
        logger.e('User not logged in');
      }
    } catch (e) {
      logger.e('Error during sign-in: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login failed. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w200,
                fontFamily: GoogleFonts.archivoBlack().fontFamily,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 50,
              width: 350,
              child: Text(
                'Login through your SNU G-Mail ID',
                style: GoogleFonts.archivo(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () => _handleSignIn(context), // Call the new method
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.red,
                ),
                height: 80,
                width: 220,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      'LOGIN',
                      style: GoogleFonts.archivo(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
