import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:text_recognition_app/models/saved_text.dart';
import 'package:text_recognition_app/screens/saved_texts_screen.dart';
import 'package:text_recognition_app/services/hive_db.dart';
import 'package:text_recognition_app/utils/helpers.dart';
import 'package:url_launcher/url_launcher.dart';

Future<Object?> resultDialog(
  BuildContext context, {
  required String text,
  required Uint8List imageData,
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Result Screen",
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: ((context, animation, secondaryAnimation, child) {
      Tween<Offset> tween;
      tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        ),
        child: child,
      );
    }),
    pageBuilder: ((context, animation, secondaryAnimation) {
      final hive = HiveService();

      return Center(
        child: Container(
          height: 320,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.94),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    const Text(
                      "Scanned Text",
                      style: TextStyle(fontSize: 26),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 10,
                              ),
                              // constraints: const BoxConstraints(maxHeight: 218),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      text,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.copy),
                            onPressed: () => copyToClipboard(
                              context,
                              true,
                              text: text,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.share),
                            onPressed: () => Share.share(
                              text,
                              subject: "Shared from Text Recognition App",
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            if (!await launchUrl(Uri.parse(
                                "https://translate.google.com/?text=$text"))) {
                              showSnackbarMessage(
                                context,
                                "Could not launch Google Translate",
                                false,
                              );
                            }
                          },
                          icon: const Icon(Icons.translate),
                          label: const Text("Translate"),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            hive.addText(
                              SavedText(
                                createdAt: DateTime.now(),
                                imgName: "vidcam.png",
                                text: text,
                                imageData: imageData,
                                id: 1,
                              ),
                            );
                            // pop(context);
                            pushPage(
                              context,
                              page: const SavedTextsScreen(),
                            );
                          },
                          icon: const Icon(Icons.save_as),
                          label: const Text("Save"),
                        ),
                      ],
                    )
                  ],
                ),
                const Positioned(
                  left: 0,
                  right: 0,
                  bottom: -48,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }),
  );
}
