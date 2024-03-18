import 'package:flutter/material.dart';
import 'package:vocabulary_nte_app/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_nte_app/model/word_model.dart';
import 'package:vocabulary_nte_app/view/screens/word_details_screen.dart';
import 'package:vocabulary_nte_app/view/styles/color_manager.dart';

class WordItemWidget extends StatelessWidget {
  const WordItemWidget({super.key, required this.wordModel});
  final WordModel wordModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        WordDetailsScreen(wordModel: wordModel)))
            .then((value) async {
          Future.delayed(const Duration(seconds: 1))
              .then((value) => ReadDataCubit.get(context).getWords());
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: getBoxDecoration(),
        child: Center(
            child: Text(
          wordModel.text,
          style: const TextStyle(
              color: ColorManager.white,
              fontWeight: FontWeight.bold,
              fontSize: 24),
        )),
      ),
    );
  }

  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(wordModel.colorCode));
  }
}
