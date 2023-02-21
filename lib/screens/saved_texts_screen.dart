import 'package:flutter/material.dart';
import 'package:text_recognition_app/constants/colors.dart';
import 'package:text_recognition_app/models/saved_text.dart';
import 'package:text_recognition_app/screens/widgets/text_tile.dart';
import 'package:text_recognition_app/services/hive_db.dart';

class SavedTextsScreen extends StatefulWidget {
  const SavedTextsScreen({super.key});

  @override
  State<SavedTextsScreen> createState() => _SavedTextsScreenState();
}

class _SavedTextsScreenState extends State<SavedTextsScreen> {
  List<SavedText> _texts = [];

  late HiveService _hiveService;

  @override
  void initState() {
    super.initState();
    _hiveService = HiveService();
    _refreshTexts();
  }

  void _refreshTexts() {
    setState(() {
      _texts = _hiveService.getAllTexts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Text"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _texts.isEmpty
              ? Center(
                  child: Column(
                    children: const [
                      SizedBox(height: 100),
                      Icon(
                        Icons.warning_amber,
                        color: primary,
                        size: 34,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "No Scanned Text",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Text("Save your text after scanning to show up here."),
                    ],
                  ),
                )
              : Column(
                  children: _texts
                      .map(
                        (t) => TextTile(
                          text: t,
                          onDelete: () {
                            _hiveService.deleteText(t.id);
                            setState(() {
                              _refreshTexts();
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
        ),
      ),
    );
  }
}
