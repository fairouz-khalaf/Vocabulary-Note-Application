class WordModel {
  final int indexAtDatabase;
  final String text;
  final bool isArabic;
  final int colorCode;
  final List<String> arabicSimilarWord;
  final List<String> englishSimilarWord;
  final List<String> arabicExample;
  final List<String> englishExample;

  const WordModel({
    required this.indexAtDatabase,
    required this.text,
    required this.isArabic,
    required this.colorCode,
    this.arabicSimilarWord = const [],
    this.englishSimilarWord = const [],
    this.arabicExample = const [],
    this.englishExample = const [],
  });
  WordModel decrementIndexAtDatabase() {
    return WordModel(
        indexAtDatabase: indexAtDatabase - 1,
        text: text,
        isArabic: isArabic,
        colorCode: colorCode,
        arabicSimilarWord: arabicSimilarWord,
        englishSimilarWord: englishSimilarWord,
        arabicExample: arabicExample,
        englishExample: englishExample);
  }

  WordModel addSimilarWord(String similarWord, bool isArabicSimilarWord) {
    List<String> newSimilarWords = _initNewSimilarWord(isArabicSimilarWord);

    newSimilarWords.add(similarWord);
    return _getWordAfterCheckSimilarWord(newSimilarWords, isArabicSimilarWord);
  }

  WordModel deleteSimilarWord(int indexAtDatabase, bool isArabicSimilarWord) {
    List<String> newSimilarWords = _initNewSimilarWord(isArabicSimilarWord);
    newSimilarWords.removeAt(indexAtDatabase);
    return _getWordAfterCheckSimilarWord(newSimilarWords, isArabicSimilarWord);
  }

  WordModel addExample(String example, bool isArabicExample) {
    List<String> newExamples = _initNewExamples(isArabicExample);
    newExamples.add(example);
    return _getWordAfterCheckExample(newExamples, isArabicExample);
  }

  WordModel deleteExample(int indexAtDatabase, bool isArabicExample) {
    List<String> newExamples = _initNewExamples(isArabicExample);
    newExamples.removeAt(indexAtDatabase);
    return _getWordAfterCheckExample(newExamples, isArabicExample);
  }

// Helper Methods For Words
  List<String> _initNewSimilarWord(bool isArabicSimilarWord) {
    if (isArabicSimilarWord) {
      return List.from(arabicSimilarWord);
    }
    {
      return List.from(englishSimilarWord);
    }
  }

  WordModel _getWordAfterCheckSimilarWord(
      List<String> newSimilarWords, bool isArabicSimilarWord) {
    return WordModel(
        indexAtDatabase: indexAtDatabase,
        text: text,
        isArabic: isArabic,
        colorCode: colorCode,
        arabicSimilarWord:
            isArabicSimilarWord ? newSimilarWords : arabicSimilarWord,
        englishSimilarWord:
            !isArabicSimilarWord ? newSimilarWords : englishSimilarWord,
        arabicExample: arabicExample,
        englishExample: englishExample);
  }

  //Helper Methods For Examples

  List<String> _initNewExamples(bool isArabicExample) {
    if (isArabicExample) {
      return List.from(arabicExample);
    }
    return List.from(englishExample);
  }

  WordModel _getWordAfterCheckExample(
      List<String> newExamples, bool isArabicExample) {
    return WordModel(
        indexAtDatabase: indexAtDatabase,
        text: text,
        isArabic: isArabic,
        colorCode: colorCode,
        arabicSimilarWord: arabicSimilarWord,
        englishSimilarWord: englishSimilarWord,
        arabicExample: isArabicExample ? newExamples : arabicExample,
        englishExample: !isArabicExample ? newExamples : englishExample);
  }
}
