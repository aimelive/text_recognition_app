import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Navigator push to another page specified
pushPage(BuildContext context, {required Widget page}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );

/// Scaffold messenger show error snackbar
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackbarMessage(
    BuildContext context, String message, bool success) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0.0,
      duration: const Duration(seconds: 6),
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: Colors.transparent,
      content: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: success ? Colors.green.shade400 : Colors.red.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

/// Popping the page
pop(BuildContext context) => Navigator.pop(context);

//Copying to clipboard
Future<void> copyToClipboard(BuildContext context, bool mounted,
    {required String text}) async {
  await Clipboard.setData(
    ClipboardData(
      text: text,
    ),
  );
  if (!mounted) return;
  showSnackbarMessage(
    context,
    "Text copied to clip board",
    true,
  );
}
