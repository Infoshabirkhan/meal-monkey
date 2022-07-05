

import 'package:flutter/cupertino.dart';

class BouncingPageTransition extends PageRouteBuilder{


  final Widget widget;
  BouncingPageTransition(this.widget):super(


          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> seeAnimation, Widget child){

            animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
            return ScaleTransition(
              alignment: Alignment.center,
              scale: animation,
              child: child,
            );
          },
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> seeAnimation){

            return widget;
          }


  );

}