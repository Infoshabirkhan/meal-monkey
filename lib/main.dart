import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_monkey/view/screens/dashboard_screen.dart';
import 'package:meal_monkey/view/screens/landing_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   systemNavigationBarColor: Colors.white, // navigation bar color
  //   statusBarColor: Colors.white, // status bar color
  // ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(

      builder : () => MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Monkey meal',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: FirebaseAuth.instance.currentUser != null ? const DashboardScreen() : const LandingScreen(),
      ),
     // designSize: const Size(360, 690),
     designSize: const Size(375, 812),

    );
  }
}
