import 'package:flutter/material.dart';
import 'package:text_recognition_app/models/saved_text.dart';
import 'package:text_recognition_app/utils/helpers.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class TextTile extends StatefulWidget {
  const TextTile({super.key, required this.text, required this.onDelete});

  final SavedText text;
  final VoidCallback onDelete;

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
                child: Image.memory(
                  widget.text.imageData,
                  fit: BoxFit.cover,
                  width: 50,
                ),
                // child: Image.asset("assets/${widget.text.imgName}"),
              ),
            ),
            title: Text(widget.text.text),
            onTap: () {
              setState(() {
                _showActions = !_showActions;
              });
            },
            subtitle: Text("Created ${timeago.format(widget.text.createdAt)}"),
            // trailing: const Icon(Icons.delete_outline),
          ),
          if (_showActions)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 30),
                  child: TextButton.icon(
                    onPressed: () async {
                      if (!await launchUrl(
                        Uri.parse(
                            "https://translate.google.com/?text=${widget.text.text}"),
                      )) {
                        showSnackbarMessage(
                          context,
                          "Could not launch Google Translate",
                          false,
                        );
                      }
                    },
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
                    onPressed: () => copyToClipboard(
                      context,
                      mounted,
                      text: widget.text.text,
                    ),
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
                    onPressed: widget.onDelete,
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
