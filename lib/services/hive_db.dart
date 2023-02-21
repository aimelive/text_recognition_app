import 'package:hive/hive.dart';
import 'package:text_recognition_app/models/saved_text.dart';

class Boxes {
  static const savedTextBox = "SAVED_TEXTS_BOX";
}

class HiveService {
  Box textsBox = Hive.box(Boxes.savedTextBox);

  List<SavedText> getAllTexts() {
    try {
      final data = textsBox.keys.map((key) {
        final value = textsBox.get(key);
        return SavedText.fromJSON(value, key);
      }).toList();
      return data.reversed.toList();
    } catch (e) {
      // print(e);
      return [];
    }
  }

  Future<void> addText(SavedText newText) async {
    await textsBox.add(SavedText.toJSON(newText));
  }

  // Delete a single text
  Future<bool> deleteText(int textKey) async {
    try {
      await textsBox.delete(textKey);
      return true;
    } catch (e) {
      return false;
    }
  }
}
