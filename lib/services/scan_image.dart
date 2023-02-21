import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../screens/widgets/result_dialog.dart';
import '../utils/helpers.dart';

class ScanImageService {
  final TextRecognizer _textRecognizer;

  ScanImageService(this._textRecognizer);

  Future<void> scanImage(
      {required CameraController cameraController,
      required BuildContext context,
      required bool mounted}) async {
    try {
      final pictureFile = await cameraController.takePicture();

      final file = File(pictureFile.path);

      final inputImage = InputImage.fromFile(file);
      final recognizedText = await _textRecognizer.processImage(inputImage);
      if (recognizedText.text.isEmpty) {
        throw Exception("No text recognized");
      }
      final bytes = await pictureFile.readAsBytes();
      if (!mounted) return;
      await resultDialog(
        context,
        imageData: bytes,
        text: recognizedText.text,
      );
    } catch (e) {
      showSnackbarMessage(
        context,
        "Something went wrong, ${e.toString()}",
        false,
      );
    }
  }
}
