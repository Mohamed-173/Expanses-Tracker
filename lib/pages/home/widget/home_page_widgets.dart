import 'package:expanses_tracker/utils/constant/colors.dart';
import 'package:expanses_tracker/utils/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar homePageAppbar() {
  return AppBar(
      title: CustomTextWidget(
    text: "Expanses Tracker",
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  ));
}
