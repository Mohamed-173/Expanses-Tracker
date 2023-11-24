import 'dart:io';

import 'package:expanses_tracker/data/storage_service.dart';

import 'package:expanses_tracker/pages/home/home_page_view.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import 'utils/constant/colors.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();

  await Hive.openBox("expense_database");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => StorageServices()),
      builder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                // primarySwatch: Colors.blue,
                appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(
                    color: AppColors.primaryText,
                  ),
                  color: Colors.white,
                  centerTitle: true,
                  elevation: 0,
                ),
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(secondary: AppColors.primaryElement),
              ),
              // home: const HomePageView(),
              routes: {
                "/": (context) => const HomePageView(),
              },
            );
          },
        );
      },
    );
  }
}
