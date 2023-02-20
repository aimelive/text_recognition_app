import 'package:flutter/material.dart';
import 'package:text_recognition_app/utils/theme.dart';

import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.theme,
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
