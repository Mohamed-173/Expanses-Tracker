import 'package:expanses_tracker/pages/home/bloc/home_page_bloc.dart';
import 'package:expanses_tracker/pages/home/home_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'utils/constant/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomePageBloc>(
      create: (context) => HomePageBloc(),
      child: ScreenUtilInit(
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
      ),
    );
  }
}
