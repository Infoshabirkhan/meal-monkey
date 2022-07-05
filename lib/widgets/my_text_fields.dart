import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_monkey/constants.dart';

class MyTextField extends StatelessWidget {
  final String errorMessage;
  final TextEditingController controller;
  final String hint;

  const MyTextField({

    Key? key,
    required this.errorMessage,
    required this.controller,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(


      controller: controller,
      validator: (value){
        if(value == '' ){
          return errorMessage;
        }else{
          return null;
        }
      },




      decoration: InputDecoration(
          border: OutlineInputBorder(


              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30)),
          filled: true,
          fillColor: MyColors.kTextField,
          hintText: hint,
          hintStyle: TextStyle(color: MyColors.kPlaceholderFont),
          contentPadding:
              EdgeInsets.only(left: 34.sp, top: 18.sp, bottom: 18.sp)),
    );
  }
}
