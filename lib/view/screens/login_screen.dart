import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meal_monkey/constants.dart';
import 'package:meal_monkey/controller/cubit/auto_validator_cubit.dart';
import 'package:meal_monkey/view/screens/gmail_information_page.dart';
import 'package:meal_monkey/view/screens/introduction_screen.dart';
import 'package:meal_monkey/view/screens/signup_screen.dart';
import 'package:meal_monkey/widgets/custom_button.dart';
import 'package:meal_monkey/widgets/my_password_field.dart';
import 'package:meal_monkey/widgets/my_text_fields.dart';
import 'package:ndialog/ndialog.dart';

import '../../controller/cubit/password_visibility_controller_cubit.dart';
import '../../widgets/custom_icon_button.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                PasswordVisibilityControllerCubit(true)),
        BlocProvider(create: (context) => AutoValidatorCubit(false))
      ],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        child: Scaffold(
          body: SafeArea(
            child: Form(
              key: formKey,
              autovalidateMode: autovalidateMode,
              child: ListView(
                padding: EdgeInsets.only(left: 24.sp, right: 24.sp),
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 50.sp,
                  ),

                  Center(
                      child: Text(
                        'Login',
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


                  // ==================== login text fields ===================== //
                  MyTextField(
                    errorMessage: 'Email is required',
                    hint: 'Your Email',
                    controller: emailController,
                  ),

                  SizedBox(
                    height: 28.sp,
                  ),

                  BlocBuilder<PasswordVisibilityControllerCubit, bool>(
                    builder: (context, state) {
                      return MyPasswordField(
                        passwordFunction: () {
                          context.read<PasswordVisibilityControllerCubit>()
                              .passwordVisibility(visible: !state);
                        },

                        visibleText: state,
                        hint: 'Password',
                        controller: passwordController,
                      );
                    },
                  ),


                  SizedBox(
                    height: 28.sp,
                  ),


                  // ================ Login button starts ==================//

                CustomButton(
                          borderColor: Colors.transparent,
                          label: 'Login',
                          buttonColor: MyColors.kMainColor,
                          function: () async {
                            if (formKey.currentState!.validate()) {

                              ProgressDialog progressDialog = ProgressDialog(
                                  (context),
                                  title: const Text('Log In!!!'),
                                  message: const Text('Please wait'));
                              progressDialog.show();

                              try {
                                UserCredential userCrediential = await FirebaseAuth
                                    .instance.signInWithEmailAndPassword(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim());

                                progressDialog.dismiss();
                                if (userCrediential.user != null) {
                                  Navigator.of(context).pushReplacement(
                                      CupertinoPageRoute(builder: (context) {
                                        return const IntroducitonScreens();
                                      }));
                                }
                              } on FirebaseAuthException catch (e) {
                                progressDialog.dismiss();
                                Fluttertoast.showToast(
                                    msg: e.code, backgroundColor: Colors.red);
                              }
                            } else {


                              setState(() {
                                autovalidateMode = AutovalidateMode.always;
                              });
                            }
                          },
                          textColor: Colors.white),

                  SizedBox(
                    height: 20.sp,
                  ),


                  // ==================== Login button starts ends ========================= //


                  TextButton(
                      style: TextButton.styleFrom(
                          primary: MyColors.kPlaceholderFont),
                      onPressed: () {

                      },
                      child: const Text(
                        'Forgot your Password?',
                        style: TextStyle(fontSize: 14),
                      )),

//              CustomButton(borderColor: Colors.white, label: 'Forgot password', buttonColor: Colors.white, onpressed: LogInScreen(), textColor: MyColors.kSecondaryFont),
                  SizedBox(
                    height: 45.sp,
                  ),

                  Center(
                      child: Text(
                        'or Login With ',
                        style: TextStyle(color: MyColors.kPlaceholderFont),
                      )),
                  SizedBox(
                    height: 24.sp,
                  ),


                  // =============== Facebook sign in starts here ============= //

                  CustomIconButton(
                    borderColor: Colors.transparent,
                    label: 'Login in with facebook',
                    buttonColor: MyColors.kBlue,
                    function: () {},
                    textColor: Colors.white,
                    icon: 'assets/icons/fbicon.png',
                  ),

                  SizedBox(
                    height: 10.sp,
                  ),


                  // =============== Google sign in starts here ============= //


                  CustomIconButton(
                      icon: "assets/icons/googleicon.png",
                      borderColor: Colors.transparent,
                      label: 'Login in with Gmail',
                      buttonColor: MyColors.kRed,
                      function: () async {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        User? user;


                        final GoogleSignIn googleSignIn = GoogleSignIn();

                        final GoogleSignInAccount? googleSignInAccount =
                        await googleSignIn.signIn();


                        if (googleSignInAccount != null) {
                          final GoogleSignInAuthentication
                          googleSignInAuthentication =
                          await googleSignInAccount.authentication;

                          final AuthCredential credential =
                          GoogleAuthProvider.credential(
                            accessToken: googleSignInAuthentication
                                .accessToken,
                            idToken: googleSignInAuthentication.idToken,
                          );

                          try {
                            final UserCredential userCredential =
                            await auth.signInWithCredential(credential);

                            user = userCredential.user;
                          } on FirebaseAuthException catch (e) {
                            Fluttertoast.showToast(msg: e.code);
                          }


                          Navigator.of(context)
                              .pushReplacement(
                              MaterialPageRoute(builder: (context) {
                                return const GmailInfoPage();
                              }));
                        } else {
                          Fluttertoast.showToast(msg: 'Failed to sign in');
                        }
                      },
                      textColor: Colors.white),


                  //================ Google sign ends starts here ================= //


                  SizedBox(
                    height: 70.sp,
                  ),


                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                              alignment: Alignment.centerRight,
//                      color: Colors.blue,
                              child:
                              const Text("Don't have account create new"))),
                      Expanded(
                        child: Container(
                            alignment: Alignment.centerLeft,
                            //                    color: Colors.red,
                            child: TextButton(
                              style:
                              TextButton.styleFrom(primary: MyColors.kRed),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                      return const SignUpScreen();
                                    }));
                              },
                              child: const Text('Sign Up'),
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
