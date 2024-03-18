import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vocabulary_nte_app/controllers/read_data_cubit/read_data_cubit_states.dart';
import 'package:vocabulary_nte_app/hive_constant.dart';
import 'package:vocabulary_nte_app/model/word_model.dart';

class ReadDataCubit extends Cubit<ReadDataCubitStates> {
  ReadDataCubit() : super(ReadDataCubitInitStates());
// I will create getter method to access cubit from any screen
  static ReadDataCubit get(context) => BlocProvider.of(context);
// 1- create my database Box
  final Box _box = Hive.box(HiveConstant.wordsBox);

  LanguageFilter languageFilter = LanguageFilter.allWords;
  SortedBy sortedBy = SortedBy.time;
  SortingType sortingType = SortingType.descending;
// 2- create updating methods
  void UpdatLanguageFilter(LanguageFilter languageFilter) {
    this.languageFilter = languageFilter;
    getWords();
  }

  void UpdateSortedBy(SortedBy sortedBy) {
    this.sortedBy = sortedBy;
    getWords();
  }

  void UpdateSortingType(SortingType sortingType) {
    this.sortingType = sortingType;
    getWords();
  }

// the major and main method of cubit
  void getWords() {
    emit(ReadDataCubitInitStates());
    try {
      List<WordModel> wordsToReturn =
          List.from(_box.get(HiveConstant.wordsList, defaultValue: []))
              .cast<WordModel>();
      _removeUnwantedWords(wordsToReturn);
      _applySorting(wordsToReturn);
      emit(ReadDataCubitSuccessStates(words: wordsToReturn));
    } catch (error) {
      emit(ReadDataCubitFailedStates(
          errorMessage: 'there is an error plz Try Again'));
    }
  }

//   method to remove unwanted words and get me te wanted words
  void _removeUnwantedWords(List<WordModel> wordsToReturn) {
    if (languageFilter == LanguageFilter.allWords) {
      return;
    }
    for (var i = 0; i < wordsToReturn.length; i++) {
      if ((languageFilter == LanguageFilter.arabicOnly &&
              wordsToReturn[i].isArabic == false) ||
          (languageFilter == LanguageFilter.englishOnly &&
              wordsToReturn[i].isArabic == true)) {
        wordsToReturn.removeAt(i);
        i--;
      }
    }
  }

  void _applySorting(List<WordModel> wordsToReturn) {
    if (SortedBy == SortedBy.time) {
      if (SortingType == SortingType.ascending) {
        return;
      } else {
        _reverse(wordsToReturn);
      }
    } else {
      wordsToReturn.sort(
          (WordModel a, WordModel b) => a.text.length.compareTo(b.text.length));
      if (sortingType == SortingType.ascending) {
        return;
      } else {
        _reverse(wordsToReturn);
      }
    }
  }

  void _reverse(List<WordModel> wordsToReturn) {
    for (var i = 0; i < wordsToReturn.length / 2; i++) {
      WordModel temp = wordsToReturn[i];
      wordsToReturn[i] = wordsToReturn[wordsToReturn.length - 1 - i];
      wordsToReturn[wordsToReturn.length - 1 - i] = temp;
    }
  }
}

enum LanguageFilter { arabicOnly, englishOnly, allWords }

enum SortedBy { time, wordLength }

enum SortingType {
  ascending,
  descending,
}
