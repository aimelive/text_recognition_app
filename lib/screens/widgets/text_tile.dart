import 'package:flutter/material.dart';
import 'package:text_recognition_app/models/saved_text.dart';

class TextTile extends StatefulWidget {
  const TextTile({super.key, required this.text});

  final SavedText text;

  @override
  State<TextTile> createState() => _TextTileState();
}

class _TextTileState extends State<TextTile> {
  bool _showActions = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset("assets/${widget.text.imgName}"),
              ),
            ),
            title: Text(widget.text.text),
            onTap: () {
              setState(() {
                _showActions = !_showActions;
              });
            },
            subtitle: const Text("Created a few months ago"),
            // trailing: const Icon(Icons.delete_outline),
          ),
          if (_showActions)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 30),
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.translate,
                      size: 16,
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: const StadiumBorder(),
                    ),
                    label: const Text(
                      "Translate",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 30),
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.copy,
                      size: 16,
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: const StadiumBorder(),
                    ),
                    label: const Text(
                      "Clipboard",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 30),
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete,
                      size: 16,
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: const StadiumBorder(),
                    ),
                    label: const Text(
                      "Remove",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
