import 'package:flutter/material.dart';
import 'package:vocabulary_nte_app/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_nte_app/view/styles/color_manager.dart';

class ColorsWidget extends StatelessWidget {
  const ColorsWidget({super.key, required this.activeColorCode});
  final int activeColorCode;
  final List<int> colorCodes = const [
    0XFFB47B84,
    0XFFB784B7,
    0XFF99BC85,
    0XFFF57D1F,
    0XFFFF90BC,
    0XFFD24545,
    0XFF6096B4,
    0XFF739072,
    0XFF554994,
    0XFF9ADCFF,
    0XFF720455,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: colorCodes.length,
        itemBuilder: (context, index) => _getItemDesign(index, context),
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
      ),
    );
  }

  Widget _getItemDesign(int index, BuildContext context) {
    return InkWell(
      onTap: () =>
          WriteDataCubit.get(context).updateColorCode(colorCodes[index]),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: activeColorCode == colorCodes[index]
                ? Border.all(color: ColorManager.white, width: 2)
                : null,
            color: Color(colorCodes[index])),
        child: activeColorCode == colorCodes[index]
            ? const Center(
                child: Icon(
                  Icons.done,
                  color: ColorManager.white,
                ),
              )
            : null,
      ),
    );
  }
}
