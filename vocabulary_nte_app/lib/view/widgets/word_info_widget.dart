import 'package:flutter/material.dart';
import 'package:vocabulary_nte_app/view/styles/color_manager.dart';

class WordInfoWidget extends StatelessWidget {
  const WordInfoWidget(
      {super.key,
      required this.color,
      required this.text,
      required this.isArabic,
      this.onPressed});
  final Color color;
  final String text;
  final bool isArabic;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: getBoxDecoration(),
      child: Row(
        children: [
          getIsArabicWidget(),
          const SizedBox(
            width: 10,
          ),
          Expanded(child: getTextWidget()),
          if (onPressed != null)
            IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.delete,
                  color: ColorManager.black,
                ))
        ],
      ),
    );
  }

  Text getTextWidget() {
    return Text(
      text,
      style: const TextStyle(
          color: ColorManager.black, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  CircleAvatar getIsArabicWidget() {
    return CircleAvatar(
      radius: 25,
      backgroundColor: ColorManager.black,
      child: Text(
        isArabic ? "Ar" : "En",
        style: TextStyle(color: color),
      ),
    );
  }

  BoxDecoration getBoxDecoration() =>
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(20));
}
