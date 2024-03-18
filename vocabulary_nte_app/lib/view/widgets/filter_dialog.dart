import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_nte_app/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_nte_app/controllers/read_data_cubit/read_data_cubit_states.dart';
import 'package:vocabulary_nte_app/view/styles/color_manager.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataCubitStates>(
        builder: (context, state) {
      return Dialog(
        backgroundColor: ColorManager.black,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              getLabelText("Language"),
              getLanguageFilter(context),
              const SizedBox(
                height: 10,
              ),
              getLabelText("Sorted By "),
              const SizedBox(
                height: 10,
              ),
              getSortedByFilter(context),
              const SizedBox(
                height: 10,
              ),
              getLabelText("Sorting Type"),
              const SizedBox(
                height: 10,
              ),
              getSortingTypeFilter(context),
            ],
          ),
        ),
      );
    });
  }

  Widget getSortedByFilter(BuildContext context) {
    return getFilterField(labels: [
      "Time",
      "WordLength"
    ], onTaps: [
      () => ReadDataCubit.get(context).UpdateSortedBy(SortedBy.time),
      () => ReadDataCubit.get(context).UpdateSortedBy(SortedBy.wordLength),
    ], conditionOfActivation: [
      ReadDataCubit.get(context).sortedBy == SortedBy.time,
      ReadDataCubit.get(context).sortedBy == SortedBy.wordLength,
    ]);
  }

  Widget getSortingTypeFilter(BuildContext context) {
    return getFilterField(labels: [
      "Ascending",
      "Descending"
    ], onTaps: [
      () => ReadDataCubit.get(context).UpdateSortingType(SortingType.ascending),
      () => ReadDataCubit.get(context).UpdateSortingType(SortingType.descending)
    ], conditionOfActivation: [
      ReadDataCubit.get(context).sortingType == SortingType.ascending,
      ReadDataCubit.get(context).sortingType == SortingType.descending,
    ]);
  }

  Widget getLanguageFilter(BuildContext context) {
    return getFilterField(labels: [
      "Arabic",
      "English",
      "All"
    ], onTaps: [
      () => ReadDataCubit.get(context)
          .UpdatLanguageFilter(LanguageFilter.arabicOnly),
      () => ReadDataCubit.get(context)
          .UpdatLanguageFilter(LanguageFilter.englishOnly),
      () => ReadDataCubit.get(context)
          .UpdatLanguageFilter(LanguageFilter.allWords),
    ], conditionOfActivation: [
      ReadDataCubit.get(context).languageFilter == LanguageFilter.arabicOnly,
      ReadDataCubit.get(context).languageFilter == LanguageFilter.englishOnly,
      ReadDataCubit.get(context).languageFilter == LanguageFilter.allWords,
    ]);
  }

  Widget getFilterField(
      {required List<String> labels,
      required List<VoidCallback> onTaps,
      required List<bool> conditionOfActivation}) {
    return Row(
      children: [
        for (int i = 0; i < labels.length; i++)
          InkWell(
            onTap: onTaps[i],
            child: Container(
              height: 40,
              padding: const EdgeInsets.only(right: 10, left: 10),
              margin: const EdgeInsets.only(
                right: 10,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: ColorManager.white),
                  color: conditionOfActivation[i]
                      ? ColorManager.white
                      : ColorManager.black),
              child: Center(
                  child: Text(
                labels[i],
                style: TextStyle(
                    color: conditionOfActivation[i]
                        ? ColorManager.black
                        : ColorManager.white),
              )),
            ),
          )
      ],
    );
  }

  Widget getLabelText(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: ColorManager.white, fontWeight: FontWeight.bold, fontSize: 18),
    );
  }
}
