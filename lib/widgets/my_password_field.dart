import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_monkey/constants.dart';

class MyPasswordField extends StatelessWidget {


  final bool visibleText;
  final TextEditingController controller;
  final String hint;
  final VoidCallback passwordFunction;

  const MyPasswordField({
    Key? key,
    required this.passwordFunction,
    required this.visibleText,
    required this.controller,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      controller: controller,


      obscureText: visibleText,
      validator: (value){
        if(value == '' ){
          return 'Password is required';
        }else if(value!.length < 6){
          return 'Please provide six digit password';
        }

        else {
          return null;
        }
      },




      decoration: InputDecoration(
        suffixIcon: Padding(
          padding:  EdgeInsets.only(left: 15.sp),
          child:  IconButton(
            onPressed: passwordFunction,
            icon: Icon(visibleText == true ? Icons.visibility_off  : Icons.remove_red_eye_outlined, color: MyColors.kIconColor,),
          )  ),
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
