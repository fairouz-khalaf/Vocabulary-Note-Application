import 'package:flutter/material.dart';
import 'package:vocabulary_nte_app/view/styles/color_manager.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorManager.white,
      ),
    );
  }
}
