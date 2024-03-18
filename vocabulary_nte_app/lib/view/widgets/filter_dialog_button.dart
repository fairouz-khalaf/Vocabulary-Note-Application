import 'package:flutter/material.dart';
import 'package:vocabulary_nte_app/view/styles/color_manager.dart';
import 'package:vocabulary_nte_app/view/widgets/filter_dialog.dart';

class FilterDialogButton extends StatelessWidget {
  const FilterDialogButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return const FilterDialog();
            });
      },
      child: const CircleAvatar(
        radius: 20,
        backgroundColor: ColorManager.white,
        child: Icon(
          Icons.filter_list,
          color: ColorManager.black,
        ),
      ),
    );
  }
}
