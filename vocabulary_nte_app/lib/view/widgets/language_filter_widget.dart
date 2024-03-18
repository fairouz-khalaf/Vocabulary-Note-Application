import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_nte_app/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_nte_app/controllers/read_data_cubit/read_data_cubit_states.dart';
import 'package:vocabulary_nte_app/view/styles/color_manager.dart';

class LanguageFilterWidget extends StatelessWidget {
  const LanguageFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataCubitStates>(
        builder: (context, state) {
      return Text(
        _mapLanguageFilterEnumToString(
            ReadDataCubit.get(context).languageFilter),
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorManager.white,
            fontSize: 18),
      );
    });
  }

  String _mapLanguageFilterEnumToString(LanguageFilter languageFilter) {
    if (languageFilter == LanguageFilter.allWords) {
      return "All Words";
    } else if (languageFilter == LanguageFilter.englishOnly) {
      return "English Only";
    } else {
      return "Arabic Only";
    }
  }
}
