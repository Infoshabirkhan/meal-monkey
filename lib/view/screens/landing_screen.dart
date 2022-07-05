
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_monkey/constants.dart';
import 'package:meal_monkey/view/screens/login_screen.dart';
import 'package:meal_monkey/view/screens/signup_screen.dart';
import 'package:meal_monkey/widgets/custom_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
            systemNavigationBarContrastEnforced: true,
        systemNavigationBarDividerColor: Colors.white
      ),

            child: Scaffold(
        body: Column(
          children: [

            // ====================== Expanded 1 ================//
            // ====================== Containing the picture and logo ================//

            Expanded(
                child: Container(
                  color: Colors.blue,
//            color: Colors.blue,
              width: 1.sw,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -10.sp,
                    left: -35.sp,
                    right: -35.sp,
                    child: Image.asset(
                      "assets/images/organe_top_shape.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: -80.sp,
                    right: 40.sp,
                    left: 40.sp,
                    child: SizedBox(
                        height: 160.sp,
                        width: 160.sp,
                        child: Image.asset("assets/images/logo.png")),
                  )
                ],
              ),
            )),





            // ======================  Expanded 2 ====================//

            // ====================== Containing Login and Signup button===============//
            Expanded(


              // ============== text ============= //

            child: Column(
              children: [
               Spacer(
                 flex: 3,
               ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 40.sp, right: 40.sp),
                            child: Text(
                              'Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep',
                              style: TextStyle(color: MyColors.kSecondaryFont), textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                // ============== Log in button ============= //

                const Spacer(

                ),
                Expanded(
                  child: CustomButton(
                    label: 'Login',
                    buttonColor: MyColors.kMainColor,
                    function: (){

                      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context){

                        return const LogInScreen();
                      }));

                    },
                    textColor: Colors.white,
                    borderColor: Colors.transparent,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),


                // ============== Create new Account button ============= //
                Expanded(
                  child: CustomButton(
                    label: 'Create New Account',
                    buttonColor: Colors.white,
                    function: (){

                      Navigator.of(context).pushReplacement(CupertinoPageRoute(

                          builder: (context){

                        return const SignUpScreen();
                      }));

                    },
                    textColor: MyColors.kMainColor,
                    borderColor: MyColors.kMainColor,
                  ),
                ),
                const Spacer(),

              ],
            ))
          ],
        ),
      ),

    );
  }
}





//       child: Scaffold(
//         body: Column(
//           children: [
//
//             // ====================== Expanded 1 ================//
//             // ====================== Containing the picture and logo ================//
//
//             Expanded(
//                 child: SizedBox(
// //            color: Colors.blue,
//               width: 1.sw,
//               child: Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   Positioned(
//                     top: -10.sp,
//                     left: -35.sp,
//                     right: -35.sp,
//                     child: Image.asset(
//                       "assets/images/organe_top_shape.png",
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Positioned(
//                     bottom: -80.h,
//                     right: 40.w,
//                     left: 40.w,
//                     child: SizedBox(
//                         height: 160.h,
//                         width: 160.w,
//                         child: Image.asset("assets/images/logo.png")),
//                   )
//                 ],
//               ),
//             )),
//
//
//
//
//
//             // ======================  Expanded 2 ====================//
//
//             // ====================== Containing Login and Signup button===============//
//             Expanded(
//
//
//               // ============== text ============= //
//
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 130.h,
//                 ),
//                 Expanded(
//                   child: Container(
//                     alignment: Alignment.center,
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             '    Discover the best foods from over 1,000\n'
//                             'restaurants and fast delivery to your doorstep',
//                             style: TextStyle(color: MyColors.kSecondaryFont),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//
//                 // ============== Log in button ============= //
//
//                 Expanded(
//                   child: CustomButton(
//                     label: 'Login',
//                     buttonColor: MyColors.kMainColor,
//                     function: (){
//
//                       Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context){
//
//                         return const LogInScreen();
//                       }));
//
//                     },
//                     textColor: Colors.white,
//                     borderColor: Colors.transparent,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20.h,
//                 ),
//
//
//                 // ============== Create new Account button ============= //
//                 Expanded(
//                   child: CustomButton(
//                     label: 'Create New Account',
//                     buttonColor: Colors.white,
//                     function: (){
//
//                       Navigator.of(context).pushReplacement(CupertinoPageRoute(
//
//                           builder: (context){
//
//                         return const SignUpScreen();
//                       }));
//
//                     },
//                     textColor: MyColors.kMainColor,
//                     borderColor: MyColors.kMainColor,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20.h,
//                 ),
//               ],
//             ))
//           ],
//         ),
//       ),
