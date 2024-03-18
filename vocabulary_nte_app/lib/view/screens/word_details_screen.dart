import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_nte_app/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_nte_app/controllers/read_data_cubit/read_data_cubit_states.dart';
import 'package:vocabulary_nte_app/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_nte_app/model/word_model.dart';
import 'package:vocabulary_nte_app/view/widgets/exception_widget.dart';
import 'package:vocabulary_nte_app/view/widgets/loading_widget.dart';
import 'package:vocabulary_nte_app/view/widgets/updat_word_dialog.dart';
import 'package:vocabulary_nte_app/view/widgets/update_word_button.dart';
import 'package:vocabulary_nte_app/view/widgets/word_info_widget.dart';

class WordDetailsScreen extends StatefulWidget {
  const WordDetailsScreen({super.key, required this.wordModel});
  final WordModel wordModel;

  @override
  State<WordDetailsScreen> createState() => _WordDetailsScreenState();
}

class _WordDetailsScreenState extends State<WordDetailsScreen> {
  late WordModel _wordModel;
  @override
  void initState() {
    super.initState();
    _wordModel = widget.wordModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(context),
        body: BlocBuilder<ReadDataCubit, ReadDataCubitStates>(
          builder: (context, state) {
            if (state is ReadDataCubitSuccessStates) {
              int index = state.words.indexWhere((element) =>
                  element.indexAtDatabase == _wordModel.indexAtDatabase);
              _wordModel = state.words[index];
              return getSuccessBody(context);
            }
            if (state is ReadDataCubitFailedStates) {
              return ExceptionWidget(
                  iconData: Icons.error, message: state.errorMessage);
            }
            return const LoadingWidget();
          },
        ));
  }

  ListView getSuccessBody(BuildContext context) {
    return ListView(children: [
      getLabelText("Word"),
      const SizedBox(
        height: 5,
      ),
      WordInfoWidget(
        color: Color(_wordModel.colorCode),
        text: _wordModel.text,
        isArabic: _wordModel.isArabic,
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          getLabelText("Similar Words"),
          const Spacer(),
          UpdateWordButton(
            color: Color(_wordModel.colorCode),
            onTap: () => showDialog(
                context: context,
                builder: ((context) => UpdateWordDialog(
                      indexAtDatabase: _wordModel.indexAtDatabase,
                      colorCode: _wordModel.colorCode,
                      isExample: false,
                    ))),
          )
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      for (int i = 0; i < _wordModel.arabicSimilarWord.length; i++)
        WordInfoWidget(
            color: Color(_wordModel.colorCode),
            text: _wordModel.arabicSimilarWord[i],
            onPressed: () => deleteArabicSimilarWord(i),
            isArabic: true),
      for (int i = 0; i < _wordModel.englishSimilarWord.length; i++)
        WordInfoWidget(
            color: Color(_wordModel.colorCode),
            text: _wordModel.englishSimilarWord[i],
            onPressed: () => deleteEnglishSimilarWord(i),
            isArabic: false),
      const SizedBox(
        height: 25,
      ),
      Row(
        children: [
          getLabelText(" Examples"),
          const Spacer(),
          UpdateWordButton(
            color: Color(_wordModel.colorCode),
            onTap: () => showDialog(
                context: context,
                builder: ((context) => UpdateWordDialog(
                      indexAtDatabase: _wordModel.indexAtDatabase,
                      colorCode: _wordModel.colorCode,
                      isExample: true,
                    ))),
          )
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      for (int i = 0; i < _wordModel.arabicExample.length; i++)
        WordInfoWidget(
            color: Color(_wordModel.colorCode),
            text: _wordModel.arabicExample[i],
            onPressed: () => deleteArabicSimilarExample(i),
            isArabic: true),
      for (int i = 0; i < _wordModel.englishExample.length; i++)
        WordInfoWidget(
            color: Color(_wordModel.colorCode),
            text: _wordModel.englishExample[i],
            onPressed: () => deleteEnglishSimilarExample(i),
            isArabic: false),
    ]);
  }

  void deleteEnglishSimilarExample(int index) {
    WriteDataCubit.get(context)
        .deleteExample(_wordModel.indexAtDatabase, index, false);
    ReadDataCubit.get(context).getWords();
  }

  void deleteArabicSimilarExample(int index) {
    WriteDataCubit.get(context)
        .deleteExample(_wordModel.indexAtDatabase, index, true);
    ReadDataCubit.get(context).getWords();
  }

  void deleteEnglishSimilarWord(int index) {
    WriteDataCubit.get(context)
        .deleteSimilarWord(_wordModel.indexAtDatabase, index, false);
    ReadDataCubit.get(context).getWords();
  }

  void deleteArabicSimilarWord(int index) {
    WriteDataCubit.get(context)
        .deleteSimilarWord(_wordModel.indexAtDatabase, index, true);
    ReadDataCubit.get(context).getWords();
  }

  Widget getLabelText(String label) {
    return Text(
      label,
      style: TextStyle(
          color: Color(_wordModel.colorCode),
          fontWeight: FontWeight.bold,
          fontSize: 25),
    );
  }

  AppBar getAppBar(context) => AppBar(
        foregroundColor: Color(_wordModel.colorCode),
        title: Text(
          "Word Details",
          style: TextStyle(color: Color(_wordModel.colorCode)),
        ),
        actions: [
          IconButton(

              // onPressed:()=> deleteWord.call(context)
              onPressed: () => deleteWord(context),
              icon: const Icon(Icons.delete))
        ],
      );

  void deleteWord(BuildContext context) {
    WriteDataCubit.get(context).deleteWord(_wordModel.indexAtDatabase);
    Navigator.pop(context);
  }
}
