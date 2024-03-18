import 'package:flutter/material.dart';
import 'package:vocabulary_nte_app/view/styles/color_manager.dart';
import 'package:vocabulary_nte_app/view/widgets/add_word_dialog.dart';

import 'package:vocabulary_nte_app/view/widgets/filter_dialog_button.dart';
import 'package:vocabulary_nte_app/view/widgets/language_filter_widget.dart';
import 'package:vocabulary_nte_app/view/widgets/words_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: getFloatingActionButton(context),
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: const Column(
        children: [
          Row(
            children: [LanguageFilterWidget(), Spacer(), FilterDialogButton()],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(child: WordsWidget())
        ],
      ),
    );
  }

  FloatingActionButton getFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: () => showDialog(
          context: context, builder: (context) => const AddWordDialog()),
      child: const Icon(
        Icons.add,
        color: ColorManager.black,
      ),
    );
  }
}
