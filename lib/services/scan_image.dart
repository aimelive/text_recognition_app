import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../screens/result_screen.dart';

class ScanImageService {
  final TextRecognizer _textRecognizer;

  ScanImageService(this._textRecognizer);

  Future<void> scanImage(
      {required CameraController cameraController,
      required BuildContext context}) async {
    final navigator = Navigator.of(context);
    try {
      final pictureFile = await cameraController.takePicture();

      final file = File(pictureFile.path);

      final inputImage = InputImage.fromFile(file);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      await navigator.push(
        MaterialPageRoute(
          builder: (_) => ResultScreen(text: recognizedText.text),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong"),
        ),
      );
    }
  }
}
