import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vocabulary_nte_app/view/styles/color_manager.dart';

abstract class ThemeManager {
  static ThemeData getAppTheme() {
    return ThemeData(
        scaffoldBackgroundColor: ColorManager.black,
        appBarTheme: const AppBarTheme(
            titleTextStyle:
                TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            centerTitle: true,
            color: ColorManager.black,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.black,
            )));
  }
}
