import 'package:flutter/material.dart';
import 'package:vocabulary_nte_app/view/styles/color_manager.dart';

class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget(
      {super.key, required this.iconData, required this.message});
  final IconData iconData;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          color: ColorManager.white,
          size: 100,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: ColorManager.white, fontSize: 24),
        ),
      ],
    );
  }
}
