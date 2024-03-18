import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_nte_app/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_nte_app/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_nte_app/controllers/write_data_cubit/write_data_cubit_states.dart';
import 'package:vocabulary_nte_app/view/styles/color_manager.dart';
import 'package:vocabulary_nte_app/view/widgets/arabic_or_english_widget.dart';
import 'package:vocabulary_nte_app/view/widgets/custom_form.dart';
import 'package:vocabulary_nte_app/view/widgets/done_button.dart';

class UpdateWordDialog extends StatefulWidget {
  const UpdateWordDialog({
    super.key,
    required this.isExample,
    required this.colorCode,
    required this.indexAtDatabase,
  });
  final bool isExample;
  final int colorCode;
  final int indexAtDatabase;

  @override
  State<UpdateWordDialog> createState() => _UpdateWordDialogState();
}

class _UpdateWordDialogState extends State<UpdateWordDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Color(widget.colorCode),
        child: BlocConsumer<WriteDataCubit, WriteDataCubitStates>(
            listener: (context, state) {
          if (state is WriteDataCubitSuccessState) {
            Navigator.pop(context);
          }
          if (state is WriteDataCubitFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(getSnackBar(state));
          }
        }, builder: ((context, state) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ArabicOrEnglishWord(
                    colorCode: widget.colorCode,
                    arabicIsSelected: WriteDataCubit.get(context).isArabic),
                SizedBox(
                  height: 20,
                ),
                CustomForm(
                    label:
                        widget.isExample ? "New Example" : "New Similar Word",
                    formKey: formKey),
                SizedBox(
                  height: 10,
                ),
                DoneButton(
                    colorCode: widget.colorCode,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        if (widget.isExample) {
                          WriteDataCubit.get(context)
                              .addExample(widget.indexAtDatabase);
                        } else {
                          WriteDataCubit.get(context)
                              .addSimilarWord(widget.indexAtDatabase);
                        }
                        ReadDataCubit.get(context).getWords();
                      }
                    })
              ],
            ),
          );
        })));
  }

  SnackBar getSnackBar(WriteDataCubitFailedState state) => SnackBar(
      backgroundColor: ColorManager.red, content: Text(state.errorMessage));
}
