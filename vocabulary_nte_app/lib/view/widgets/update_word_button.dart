import 'package:flutter/material.dart';
import 'package:vocabulary_nte_app/view/styles/color_manager.dart';

class UpdateWordButton extends StatelessWidget {
  const UpdateWordButton({super.key, required this.color, required this.onTap});
  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 40,
        decoration: getBoxDecoration(),
        child: const Icon(
          Icons.add,
          color: ColorManager.black,
        ),
      ),
    );
  }

  BoxDecoration getBoxDecoration() =>
      BoxDecoration(borderRadius: BorderRadius.circular(20), color: color);
}
