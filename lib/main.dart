import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tedxwordle/firebase_options.dart';
import 'screens/wordle.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordle',
      home: const SafeArea(
        child: Wordle(),
      ),
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/wordle': (context) => const Wordle(),
      },
    );
  }
}
