import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/my_text_fields.dart';
import 'introduction_screen.dart';

class GmailInfoPage extends StatefulWidget {
  const GmailInfoPage({Key? key}) : super(key: key);

  @override
  State<GmailInfoPage> createState() => _GmailInfoPageState();
}

class _GmailInfoPageState extends State<GmailInfoPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController mobileNoController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  bool confirmPasswordVisibility = true;

  bool passwordVisibility = true;

  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
return Scaffold(
  body: Padding(
    padding: EdgeInsets.only(left: 34.sp, right: 34.sp),
    child: Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 60.sp),
          Center(


              child: Text(
                'Your data ',
                style: TextStyle(fontSize: 30.sp),
              )),
          SizedBox(
            height: 12.sp,
          ),
          Center(
              child: Text(
                'Add your detail to login',
                style: TextStyle(color: MyColors.kPlaceholderFont),
              )),
          SizedBox(
            height: 36.sp,
          ),
          MyTextField(
            errorMessage: 'Name is required',
            hint: 'Name', controller: nameController,),
          SizedBox(
            height: 28.sp,
          ),
          SizedBox(
            height: 28.sp,
          ),
          MyTextField(
            errorMessage: 'Mobile number is required',
            hint: 'Mobile No', controller: mobileNoController,),
          SizedBox(
            height: 28.sp,
          ),
          MyTextField(
            errorMessage: 'Address is required',
            hint: 'Address', controller: addressController,),
          SizedBox(
            height: 28.sp,
          ),

          CustomButton(
              borderColor: Colors.transparent,
              label: 'Continue',
              buttonColor: MyColors.kMainColor,
              function: () async {

                if (formKey.currentState!.validate()) {
                  CollectionReference  ref = FirebaseFirestore
                      .instance.collection('users');
                  String uid = user!.uid;

                  await ref.doc(uid).set({

                    'Name': nameController.text.trim(),
                    'email': user!.email,
                    'mobile_no': mobileNoController.text.trim(),
                    'address': addressController.text.trim(),
                    'uid': uid,
                    'profile_image': ''
                  });

                  Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context){

                    return const IntroducitonScreens();
                  }));
                  }






              },
              textColor: Colors.white),
          SizedBox(
            height: 24.sp,
          ),
        ],
      ),
    ),
  ),

);


  }
}




// return Scaffold(
//   body: Padding(
//     padding: EdgeInsets.only(left: 34.sp, right: 34.sp),
//     child: Form(
//       key: formKey,
//       autovalidateMode: autovalidateMode,
//       child: ListView(
//         physics: const BouncingScrollPhysics(),
//         children: [
//           SizedBox(height: 60.sp),
//           Center(
//               child: Text(
//                 'Your data ',
//                 style: TextStyle(fontSize: 30.sp),
//               )),
//           SizedBox(
//             height: 12.sp,
//           ),
//           Center(
//               child: Text(
//                 'Add your detail to login',
//                 style: TextStyle(color: MyColors.kPlaceholderFont),
//               )),
//           SizedBox(
//             height: 36.sp,
//           ),
//           MyTextField(
//             errorMessage: 'Name is required',
//             hint: 'Name', controller: nameController,),
//           SizedBox(
//             height: 28.sp,
//           ),
//           SizedBox(
//             height: 28.sp,
//           ),
//           MyTextField(
//             errorMessage: 'Mobile number is required',
//             hint: 'Mobile No', controller: mobileNoController,),
//           SizedBox(
//             height: 28.sp,
//           ),
//           MyTextField(
//             errorMessage: 'Address is required',
//             hint: 'Address', controller: addressController,),
//           SizedBox(
//             height: 28.sp,
//           ),
//
//           CustomButton(
//               borderColor: Colors.transparent,
//               label: 'Continue',
//               buttonColor: MyColors.kMainColor,
//               function: () async {
//
//                 if (formKey.currentState!.validate()) {
//                   CollectionReference  ref = FirebaseFirestore
//                       .instance.collection('users');
//                   String uid = user!.uid;
//
//                   await ref.doc(uid).set({
//
//                     'Name': nameController.text.trim(),
//                     'email': user!.email,
//                     'mobile_no': mobileNoController.text.trim(),
//                     'address': addressController.text.trim(),
//                     'uid': uid,
//                     'profile_image': ''
//                   });
//
//                   Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context){
//
//                     return IntroducitonScreens();
//                   }));
//                   }
//
//
//
//
//
//
//               },
//               textColor: Colors.white),
//           SizedBox(
//             height: 24.sp,
//           ),
//         ],
//       ),
//     ),
//   ),
//
// );
