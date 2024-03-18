import '../../model/word_model.dart';

abstract class ReadDataCubitStates {}

class ReadDataCubitInitStates extends ReadDataCubitStates {}

class ReadDataCubitLoadingStates extends ReadDataCubitStates {}

class ReadDataCubitSuccessStates extends ReadDataCubitStates {
  final List<WordModel> words;

  ReadDataCubitSuccessStates({required this.words});
}

class ReadDataCubitFailedStates extends ReadDataCubitStates {
  final String errorMessage;

  ReadDataCubitFailedStates({required this.errorMessage});
}
