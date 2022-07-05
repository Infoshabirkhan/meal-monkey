
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final Color textColor;
  final Color buttonColor;
  final String label;
  //final Widget onpressed;
  final Color borderColor;
  final VoidCallback function ;

   const CustomButton({ required this.function , required this.borderColor , required this.label, required this.buttonColor,  required this.textColor,Key? key, String? icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   ElevatedButton(
        style: ElevatedButton.styleFrom(
            side: BorderSide(
              color: borderColor,
            ),

            primary: buttonColor,
            fixedSize: Size(307.sp, 56.sp),
            shape: RoundedRectangleBorder(


                borderRadius: BorderRadius.circular(34.sp)

            )

        ),
        onPressed: function,
        // onPressed: (){
        //   Navigator.of(context).push(MaterialPageRoute(builder: (context){
        //
        //     return onpressed;
        //   }));
        // },

    child: Text(label, style: TextStyle(color: textColor ,  fontSize: 15.sp),),
    );
      }
}

