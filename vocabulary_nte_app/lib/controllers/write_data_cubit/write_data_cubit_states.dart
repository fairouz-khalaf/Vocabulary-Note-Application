abstract class WriteDataCubitStates {}

class WriteDataCubitInitState extends WriteDataCubitStates {}

class WriteDataCubitLoadingState extends WriteDataCubitStates {}

class WriteDataCubitSuccessState extends WriteDataCubitStates {}

class WriteDataCubitFailedState extends WriteDataCubitStates {
  final String errorMessage;

  WriteDataCubitFailedState({required this.errorMessage});
}
