import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconButton extends StatelessWidget {
  final Color textColor;
  final Color buttonColor;
  final String label;

  final VoidCallback function;
  //  final Widget onpressed;
  final Color borderColor;
  final String icon;

  const CustomIconButton(
      {

        required this.function,
        required this.borderColor,
      required this.label,
      required this.buttonColor,
      required this.textColor,
      Key? key,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          side: BorderSide(
            color: borderColor,
          ),
          primary: buttonColor,
          fixedSize: Size(307.sp, 56.sp),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(34.sp))),
      onPressed: function,
      child: Row(
        children: [
          Expanded(child: Image.asset(icon)),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(color: textColor, fontSize: 15.sp),
            ),
          ),
        ],
      ),
    );
  }
}
