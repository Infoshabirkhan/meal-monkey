import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meal_monkey/widgets/my_password_field.dart';
import 'package:ndialog/ndialog.dart';

import '../../constants.dart';
import '../../controller/cubit/password_visibility_controller_cubit.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/my_text_fields.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}


class _SignUpScreenState extends State<SignUpScreen> {


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

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark

      ),
      child: BlocProvider(
        create: (context) => PasswordVisibilityControllerCubit(true),
        child: Scaffold(
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
                        'Sign Up',
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
                  MyTextField(
                    errorMessage: 'Email is required',
                    hint: 'Email', controller: emailController,),
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
                  BlocBuilder<PasswordVisibilityControllerCubit, bool>(
                    builder: (context, state) {
                      return MyPasswordField(
                        passwordFunction: () {

                          context.read<PasswordVisibilityControllerCubit>().passwordVisibility(visible: !state);


                        },

                        visibleText: state,
                        hint: 'Password', controller: passwordController,);
                    },
                  ),
                  SizedBox(
                    height: 28.sp,
                  ),
                  BlocBuilder<PasswordVisibilityControllerCubit, bool>(
                    builder: (context, state) {
                      return MyPasswordField(

                           passwordFunction: () {

                             context.read<PasswordVisibilityControllerCubit>().passwordVisibility(visible: !state);

                           },

                          visibleText: state,
                          hint: 'Confirm Password',
                          controller: confirmPasswordController);
                    },
                  ),
                  SizedBox(
                    height: 28.sp,
                  ),
                  CustomButton(
                      borderColor: Colors.transparent,
                      label: 'Sign Up',
                      buttonColor: MyColors.kMainColor,
                      function: () async {
                        if (formKey.currentState!.validate()) {
                          ProgressDialog progressDialog = ProgressDialog(
                              (context),
                              title: const Text('Signing up!!!'),
                              message: const Text('Please wait'));

                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            progressDialog.show();
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Please enter the same password');
                            return;
                          }


                          try {
                            UserCredential userCrediential = await FirebaseAuth
                                .instance.createUserWithEmailAndPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim());


                            if (userCrediential.user != null) {
                              CollectionReference  ref = FirebaseFirestore
                                  .instance.collection('users');
                              String uid = userCrediential.user!.uid;

                              await ref.doc(uid).set({

                                'Name': nameController.text.trim(),
                                'email': emailController.text.trim(),
                                'mobile_no': mobileNoController.text.trim(),
                                'address': addressController.text.trim(),
                                'uid': uid,
                                'profile_image': ''
                              });


                              progressDialog.dismiss();

                              Fluttertoast.showToast(
                                  msg: 'Successfully created your account',
                                  textColor: Colors.white,
                                  backgroundColor: Colors.green);


                              Navigator.of(context).pushReplacement(
                                  CupertinoPageRoute(builder: (context) {
                                    return const LogInScreen();
                                  }));
                            }
                          } on FirebaseAuthException catch (e) {
                            progressDialog.dismiss();
                            Fluttertoast.showToast(
                                msg: e.code,
                                backgroundColor: Colors.redAccent,
                                textColor: Colors.white);
                          }
                        } else {
                          setState(() {

                          });
                          autovalidateMode = AutovalidateMode.always;
                        }
                      },
                      textColor: Colors.white),
                  SizedBox(
                    height: 24.sp,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                              alignment: Alignment.centerRight,
//                      color: Colors.blue,
                              child: const Text('Already have an Account?'))),
                      Expanded(
                        child: Container(
                            alignment: Alignment.centerLeft,
                            //                    color: Colors.red,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  primary: MyColors.kRed),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacement(
                                    CupertinoPageRoute(builder: (context) {
                                      return const LogInScreen();
                                    }));
                              },
                              child: const Text('Log In'),
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
