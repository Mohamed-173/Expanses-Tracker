import 'package:expanses_tracker/utils/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double? height;
  final double? width;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final TextAlign? textAlign;
  final int? maxLine;
  final TextOverflow? textOverflow;

  const CustomTextWidget({
    super.key,
    required this.text,
    this.height,
    this.width,
    this.fontSize,
    this.fontWeight,
    this.textColor,
    this.textAlign,
    this.maxLine,
    this.textOverflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      maxLines: maxLine ?? 1,
      overflow: textOverflow,
      style: TextStyle(
        color: textColor ?? AppColors.primaryText,
        fontSize: fontSize ?? 15.sp,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}
