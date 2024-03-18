import 'package:flutter/material.dart';
import 'package:vocabulary_nte_app/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_nte_app/view/styles/color_manager.dart';

class ArabicOrEnglishWord extends StatelessWidget {
  const ArabicOrEnglishWord(
      {super.key, required this.colorCode, required this.arabicIsSelected});
  final int colorCode;
  final bool arabicIsSelected;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        getCircleContainer(true, context),
        const SizedBox(width: 5),
        getCircleContainer(false, context)
      ],
    );
  }

  InkWell getCircleContainer(bool buildIsArabic, BuildContext context) {
    return InkWell(
      onTap: () => WriteDataCubit.get(context).updateIsArabic(buildIsArabic),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: ColorManager.white),
            shape: BoxShape.circle,
            color: buildIsArabic == arabicIsSelected
                ? ColorManager.white
                : Color(colorCode)),
        child: Center(
          child: Text(
            buildIsArabic ? "ar" : "en",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: !(buildIsArabic == arabicIsSelected)
                    ? ColorManager.white
                    : Color(colorCode)),
          ),
        ),
      ),
    );
  }
}
