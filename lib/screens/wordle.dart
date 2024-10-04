import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tedxwordle/auth/login.dart';

class Wordle extends StatelessWidget {
  const Wordle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TED',
                  style: GoogleFonts.archivoBlack(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    color: Colors.red,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'x',
                      style: GoogleFonts.archivoBlack(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ],
            ),
            Text(
              'WORDLE',
              style: GoogleFonts.archivoBlack(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 40),

            //Play Button

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.red,
                ),
                height: 80,
                width: 180,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      'PLAY',
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
            const SizedBox(
              height: 20,
            ),

            //Leaderboard Button

            TextButton(
              onPressed: () {},
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
                      'LEADERBOARD',
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
