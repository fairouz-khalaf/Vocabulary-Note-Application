import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_nte_app/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_nte_app/controllers/read_data_cubit/read_data_cubit_states.dart';
import 'package:vocabulary_nte_app/model/word_model.dart';
import 'package:vocabulary_nte_app/view/widgets/exception_widget.dart';
import 'package:vocabulary_nte_app/view/widgets/loading_widget.dart';
import 'package:vocabulary_nte_app/view/widgets/word_item_widget.dart';

class WordsWidget extends StatelessWidget {
  const WordsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataCubitStates>(
      builder: ((context, state) {
        if (state is ReadDataCubitSuccessStates) {
          if (state.words.isEmpty) {
            return getEmptyWordsWidget();
          }
          return getWordsWidget(state.words);
        } else if (state is ReadDataCubitFailedStates) {
          return getFailedWidget(state.errorMessage);
        } else {
          return getLoadingWidget();
        }
      }),
    );
  }
}

Widget getWordsWidget(List<WordModel> words) {
  return GridView.builder(
      itemCount: words.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 2 / 1.5,
          crossAxisCount: 2),
      itemBuilder: ((context, index) {
        return WordItemWidget(
          wordModel: words[index],
        );
      }));
}

Widget getEmptyWordsWidget() {
  return const ExceptionWidget(
      iconData: Icons.list_rounded, message: "Empty Words List");
}

Widget getFailedWidget(String message) {
  return ExceptionWidget(iconData: Icons.error, message: message);
}

Widget getLoadingWidget() {
  return const LoadingWidget();
}
