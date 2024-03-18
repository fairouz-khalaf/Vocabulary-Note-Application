import 'package:flutter_robusta_hive/flutter_robusta_hive.dart';
import 'word_model.dart';

class WordTypeAdapter extends TypeAdapter<WordModel> {
  @override
  WordModel read(BinaryReader reader) {
    return WordModel(
        indexAtDatabase: reader.readInt(),
        text: reader.readString(),
        isArabic: reader.readBool(),
        colorCode: reader.readInt(),
        arabicSimilarWord: reader.readStringList(),
        englishSimilarWord: reader.readStringList(),
        arabicExample: reader.readStringList(),
        englishExample: reader.readStringList());
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, WordModel obj) {
    writer.writeInt(obj.indexAtDatabase);
    writer.writeString(obj.text);
    writer.writeBool(obj.isArabic);
    writer.writeInt(obj.colorCode);
    writer.writeStringList(obj.arabicSimilarWord);
    writer.writeStringList(obj.englishSimilarWord);
    writer.writeStringList(obj.arabicExample);
    writer.writeStringList(obj.englishExample);
  }
}
