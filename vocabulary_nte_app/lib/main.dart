import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_robusta_hive/flutter_robusta_hive.dart';
import 'package:vocabulary_nte_app/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary_nte_app/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:vocabulary_nte_app/hive_constant.dart';
import 'package:vocabulary_nte_app/view/screens/home_screen.dart';
import 'package:vocabulary_nte_app/view/styles/theme_manager.dart';
import 'model/word_type_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WordTypeAdapter());
  await Hive.openBox(HiveConstant.wordsBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ReadDataCubit()..getWords()),
          BlocProvider(create: (context) => WriteDataCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeManager.getAppTheme(),
          home: const HomeScreen(),
        ));
  }
}
