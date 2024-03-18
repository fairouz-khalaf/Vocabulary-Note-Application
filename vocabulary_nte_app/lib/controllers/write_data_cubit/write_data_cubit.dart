import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vocabulary_nte_app/controllers/write_data_cubit/write_data_cubit_states.dart';
import 'package:vocabulary_nte_app/hive_constant.dart';
import 'package:vocabulary_nte_app/model/word_model.dart';

class WriteDataCubit extends Cubit<WriteDataCubitStates> {
  WriteDataCubit() : super(WriteDataCubitInitState());
// I will create getter method to access Write cubit from any screen

  static WriteDataCubit get(context) => BlocProvider.of(context);
//firstly will write tha needed attributes
//1-   declare box from it i will get my data
  final Box box = Hive.box(HiveConstant.wordsBox);
  // 2- declare and init the other attributes
  String text = "";
  bool isArabic = true;
  int colorCode = 0XFFB47B84;

// Secondly will implement tha needed methods

  void updateText(String text) {
    this.text = text;
  }

  void updateIsArabic(bool isArabic) {
    this.isArabic = isArabic;
    emit(WriteDataCubitInitState());
  }

  void updateColorCode(int colorCode) {
    this.colorCode = colorCode;
    emit(WriteDataCubitInitState());
  }

// the following is the needed methods to make update on word
  void addSimilarWord(
    int indexAtDatabase,
  ) {
    emit(WriteDataCubitLoadingState());
    try {
      List<WordModel> words = _getWordsFromDatabase();
      words[indexAtDatabase] =
          words[indexAtDatabase].addSimilarWord(text, isArabic);
      box.put(HiveConstant.wordsList, words);
      emit(WriteDataCubitSuccessState());
    } catch (e) {
      emit(WriteDataCubitFailedState(
          errorMessage: 'We have problem when we add word ,please Try Again '));
    }
  }

  void addExample(int indexAtDatabase) {
    emit(WriteDataCubitLoadingState());
    try {
      List<WordModel> words = _getWordsFromDatabase();
      words[indexAtDatabase] =
          words[indexAtDatabase].addExample(text, isArabic);
      box.put(HiveConstant.wordsList, words);
      emit(WriteDataCubitSuccessState());
    } catch (e) {
      emit(WriteDataCubitFailedState(
          errorMessage:
              'We have problem when we add Example ,please Try Again '));
    }
  }

  void deleteSimilarWord(
      int indexAtDatabase, int indexAtSimilarWords, bool isArabicSimilarWord) {
    emit(WriteDataCubitLoadingState());
    try {
      List<WordModel> words = _getWordsFromDatabase();
      words[indexAtDatabase] = words[indexAtDatabase]
          .deleteSimilarWord(indexAtSimilarWords, isArabicSimilarWord);
      box.put(HiveConstant.wordsList, words);
      emit(WriteDataCubitSuccessState());
    } catch (e) {
      emit(WriteDataCubitFailedState(
          errorMessage:
              'We have problem when we delete similar words ,please Try Again '));
    }
  }

  void deleteExample(
      int indexAtDatabase, int indexAtExamples, bool isArabicExample) {
    emit(WriteDataCubitLoadingState());
    try {
      List<WordModel> words = _getWordsFromDatabase();
      words[indexAtDatabase] = words[indexAtDatabase]
          .deleteExample(indexAtExamples, isArabicExample);
      box.put(HiveConstant.wordsList, words);
      emit(WriteDataCubitSuccessState());
    } catch (e) {
      emit(WriteDataCubitFailedState(
          errorMessage:
              'We have problem when we delete similar Example ,please Try Again '));
    }
  }

// the following is main methods
  void addWord() {
    emit(WriteDataCubitLoadingState());
    try {
      //1- get data from database and put it in new list called words
      List<WordModel> words = _getWordsFromDatabase();

      //2- add new word in my new list that called words
      words.add(WordModel(
          indexAtDatabase: words.length,
          text: text,
          isArabic: isArabic,
          colorCode: colorCode));
      // will add new list(words) to box
      box.put(HiveConstant.wordsList, words);
      emit(WriteDataCubitSuccessState());
    } catch (e) {
      emit(WriteDataCubitFailedState(
          errorMessage: 'We have problem when we add word ,please Try Again '));
    }
  }

  void deleteWord(int indexAtDatabase) {
    emit(WriteDataCubitLoadingState());
    try {
      // 1- get data from data base and save it in new list (words)
      List<WordModel> words = _getWordsFromDatabase();
// 2- remove word that exist in given index in data base
      words.removeAt(indexAtDatabase);
      //3- decrement index for each word in data base after remove
      for (var i = indexAtDatabase; i < words.length; i++) {
        words[i] = words[i].decrementIndexAtDatabase();
      }
      // put new list after delete in database
      box.put(HiveConstant.wordsList, words);
      emit(WriteDataCubitSuccessState());
    } catch (e) {
      emit(WriteDataCubitFailedState(
          errorMessage: 'We have problem when we add word ,please Try Again'));
    }
  }

  List<WordModel> _getWordsFromDatabase() =>
      List.from(box.get(HiveConstant.wordsList, defaultValue: []))
          .cast<WordModel>();
}
