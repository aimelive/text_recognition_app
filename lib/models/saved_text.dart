import 'package:flutter/services.dart';

class SavedText {
  int id;
  String imgName;
  String text;
  Uint8List imageData;
  DateTime createdAt;

  SavedText({
    required this.createdAt,
    required this.imgName,
    required this.text,
    required this.id,
    required this.imageData,
  });

  static SavedText fromJSON(dynamic json, int id) {
    return SavedText(
      createdAt: json["createdAt"],
      imgName: json["imgName"],
      text: json["text"],
      imageData: json["imageData"],
      id: id,
    );
  }

  static Map<String, dynamic> toJSON(SavedText text) {
    return {
      "createdAt": text.createdAt,
      "imgName": text.imgName,
      "text": text.text,
      "imageData": text.imageData
    };
  }
}

// List<SavedText> dummySavedText = [
//   SavedText(
//     createdAt: DateTime.now(),
//     imgName: "vidcam.png",
//     text: "VidCam 1",
//     id: 1,
//   ),
//   SavedText(
//     createdAt: DateTime.now(),
//     imgName: "vidcam.png",
//     text: "VidCam 2",
//     id: 2,
//   ),
//   SavedText(
//     createdAt: DateTime.now(),
//     imgName: "vidcam.png",
//     text: "VidCam 3",
//     id: 3,
//   ),
//   SavedText(
//     createdAt: DateTime.now(),
//     imgName: "vidcam.png",
//     text: "VidCam 4",
//     id: 4,
//   ),
//   SavedText(
//     createdAt: DateTime.now(),
//     imgName: "vidcam.png",
//     text: "VidCam 5",
//     id: 5,
//   ),
// ];
