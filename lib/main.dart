import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:text_recognition_app/services/hive_db.dart';
import 'package:text_recognition_app/utils/theme.dart';

import 'screens/home.dart';

void main() async {
  //Initializing flutter hive database
  await Hive.initFlutter();

  //Opening database of the saved text box
  await Hive.openBox(Boxes.savedTextBox);

  //Running the application
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
