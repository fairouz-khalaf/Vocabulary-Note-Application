import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_nte_app/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_nte_app/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_nte_app/controllers/write_data_cubit/write_data_cubit_states.dart';
import 'package:vocabulary_nte_app/view/styles/color_manager.dart';
import 'package:vocabulary_nte_app/view/widgets/arabic_or_english_widget.dart';
import 'package:vocabulary_nte_app/view/widgets/colors_widget.dart';
import 'package:vocabulary_nte_app/view/widgets/custom_form.dart';
import 'package:vocabulary_nte_app/view/widgets/done_button.dart';

class AddWordDialog extends StatefulWidget {
  const AddWordDialog({super.key});

  @override
  State<AddWordDialog> createState() => _AddWordDialogState();
}

class _AddWordDialogState extends State<AddWordDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: BlocConsumer<WriteDataCubit, WriteDataCubitStates>(
      listener: (context, state) {
        if (state is WriteDataCubitSuccessState) {
          Navigator.pop(context);
        }
        if (state is WriteDataCubitFailedState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(_getSnakBar(state.errorMessage));
        }
      },
      builder: (context, state) {
        return AnimatedContainer(
          padding: const EdgeInsets.all(20),
          duration: const Duration(milliseconds: 700),
          color: Color(WriteDataCubit.get(context).colorCode),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ArabicOrEnglishWord(
                colorCode: WriteDataCubit.get(context).colorCode,
                arabicIsSelected: WriteDataCubit.get(context).isArabic,
              ),
              SizedBox(
                height: 13,
              ),
              ColorsWidget(
                  activeColorCode: WriteDataCubit.get(context).colorCode),
              SizedBox(
                height: 13,
              ),
              CustomForm(label: "New Word", formKey: formKey),
              const SizedBox(
                height: 15,
              ),
              DoneButton(
                  colorCode: WriteDataCubit.get(context).colorCode,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      WriteDataCubit.get(context).addWord();
                      ReadDataCubit.get(context).getWords();
                    }
                  })
            ],
          ),
        );
      },
    ));
  }

  SnackBar _getSnakBar(String errorMessage) =>
      SnackBar(content: Text(errorMessage), backgroundColor: ColorManager.red);
}
