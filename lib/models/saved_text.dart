class SavedText {
  int id;
  String imgName;
  String text;
  DateTime createdAt;
  SavedText({
    required this.createdAt,
    required this.imgName,
    required this.text,
    required this.id,
  });
}

List<SavedText> dummySavedText = [
  SavedText(
    createdAt: DateTime.now(),
    imgName: "vidcam.png",
    text: "VidCam 1",
    id: 1,
  ),
  SavedText(
    createdAt: DateTime.now(),
    imgName: "vidcam.png",
    text: "VidCam 2",
    id: 2,
  ),
  SavedText(
    createdAt: DateTime.now(),
    imgName: "vidcam.png",
    text: "VidCam 3",
    id: 3,
  ),
  SavedText(
    createdAt: DateTime.now(),
    imgName: "vidcam.png",
    text: "VidCam 4",
    id: 4,
  ),
  SavedText(
    createdAt: DateTime.now(),
    imgName: "vidcam.png",
    text: "VidCam 5",
    id: 5,
  ),
];
