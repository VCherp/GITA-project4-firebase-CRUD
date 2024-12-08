import 'package:flutter/material.dart';

import '/utility/firebase_wrapper.dart';
import '/screens/main_screen.dart';

void main() {
  FirebaseWrapper().initialize();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color.fromRGBO(255, 145, 0, 1),
      ),
      home: MainScreen(),
    );
  }
}