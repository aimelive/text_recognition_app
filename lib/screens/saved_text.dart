import 'package:flutter/material.dart';
import 'package:text_recognition_app/models/saved_text.dart';
import 'package:text_recognition_app/screens/widgets/text_tile.dart';

class SavedText extends StatelessWidget {
  const SavedText({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Text"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: dummySavedText
                .map(
                  (t) => TextTile(text: t),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
