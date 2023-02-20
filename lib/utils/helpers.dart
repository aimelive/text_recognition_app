import 'package:flutter/material.dart';

/// Navigator push to another page specified
pushPage(BuildContext context, {required Widget page}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );

/// Scaffold messenger show error snackbar
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showError(
    BuildContext context, String error) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0.0,
      duration: const Duration(seconds: 6),
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: Colors.transparent,
      content: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.red.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          "Something went wrong $error",
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

/// Popping the page
pop(BuildContext context) => Navigator.pop(context);
