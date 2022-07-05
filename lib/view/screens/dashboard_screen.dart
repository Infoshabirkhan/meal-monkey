import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:meal_monkey/constants.dart';
import 'package:meal_monkey/controller/page_controller.dart';
import 'package:meal_monkey/view/screens/home_page.dart';
import 'package:meal_monkey/view/screens/more_info_screen.dart';
import 'package:meal_monkey/view/screens/offer_screen.dart';
import 'package:meal_monkey/view/screens/profile_screen.dart';

import '../../controller/cubit/bottom_navigation_cubit.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
      child: BlocProvider(
        create: (context) => BottomNavigationCubit(0),
        child: Scaffold(
            extendBody: true,
            floatingActionButton: SizedBox(
              width: 70.w,
              height: 70.h,
              child: FloatingActionButton(
                elevation: 10,

                backgroundColor: MyColors.kMainColor,

                onPressed: () {},
                child: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 30.sp,
                ), //icon inside button
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(), //shape of notch
              notchMargin: 15.0.sp,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.sp),
                      topRight: Radius.circular(15.sp)),
                  //  color: Colors.white.withOpacity(0.9),
                  // boxShadow: [
                  //   BoxShadow(color: Colors.grey.withAlpha(100), blurRadius: 10)
                  // ]
                ),
                height: 70.h,
                child: BlocBuilder<BottomNavigationCubit, int>(
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.only(top: 10.sp),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.max,
                        //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          getBottomNavItems(
                              controller: BottomPageController.controller,
                              currentIndex: _currentIndex,
                              pageIndex: 0,
                              icon: Icons.home,
                              label: 'Home'),
                          getBottomNavItems(
                              controller: BottomPageController.controller,
                              currentIndex: _currentIndex,
                              pageIndex: 1,
                              icon: Icons.shopping_bag,
                              label: 'Offers'),
                          const Spacer(
                            flex: 1,
                          ),
                          getBottomNavItems(
                              controller: BottomPageController.controller,
                              currentIndex: _currentIndex,
                              pageIndex: 2,
                              icon: Icons.person,
                              label: 'Profile'),
                          getBottomNavItems(
                              controller: BottomPageController.controller,
                              currentIndex: _currentIndex,
                              pageIndex: 3,
                              icon: Icons.more,
                              label: 'More'),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            body: BlocBuilder<BottomNavigationCubit, int>(

              builder: (context, state) {
                return PageView(
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (x) {
                    //! the page index x goes to the state function

                    context.read<BottomNavigationCubit>().getIndex(index: x);
                    print('================');
                    print(state);

                    ///here the value of state i put in the local variable
                    /// _current index

                    _currentIndex = context.read<BottomNavigationCubit>().state;
                  },
                  controller: BottomPageController.controller,
                  children: const [
                    HomePage(),
                    OfferScreen(),
                    ProfileScreen(),
                    MoreInfoScreen(),
                  ],
                );
              },
            )),
      ),
    );
  }
}


Widget getBottomNavItems(
    {required IconData icon,
    required String label,
    required PageController controller,
    required int pageIndex,
    required int currentIndex}) {
  return Expanded(
      //flex: 0,
      child: InkWell(
    // radius: 30,
    borderRadius: BorderRadius.circular(80.sp),
    onTap: () {
      controller.jumpToPage(pageIndex); //0
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: Icon(
          icon,
          color: currentIndex == pageIndex
              ? MyColors.kMainColor
              : MyColors.kIconColor,
        )),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: currentIndex == pageIndex
                  ? MyColors.kMainColor
                  : MyColors.kIconColor,
            ),
          ),
        )
      ],
    ),
  ));
}

//// bottom navigation bar code

// int index = 0;
//
// void selectedTab(selectedIndex){
//
//   setState(() {
//     index = selectedIndex;
//   });
// }
//
// List<Map<String, dynamic>> screensData = [
//
//   {
//     'page': const HomePage(),
//     'title' : 'Menu',
//   },
//
//   {
//     'page': const OfferScreen(),
//     'title' : 'offer',
//   },
//   {
//     'page': const ProfileScreen(),
//     'title' : 'Profile',
//   },
//   {
//     'page': const MoreInfoScreen(),
//     'title' : 'More',
//   }
//
// ];

//
// floatingActionButton:SizedBox(
// width: 70.w,
// height: 70.h,
// child: FloatingActionButton(
// elevation: 10,
//
// backgroundColor: MyColors.kMainColor,
//
// onPressed: (){
//
// },
// child: Icon(Icons.home, color: Colors.white, size: 30.sp,), //icon inside button
// ),
// ),
//
// // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

//
// InkWell(
//   onTap: (){
//
//
//
//     controller.jumpToPage(0);
//   },
//   child: Container(
//     margin: EdgeInsets.all(10.sp),
//     child: Column(
//       children: [
//       Icon(Icons.menu, color: MyColors.kIconColor,),
//         Text('Home', style: TextStyle(color: MyColors.kIconColor,),)
//
//       ],
//     ),
//   ),
// ),
//
// InkWell(
//   onTap: (){
//
//     controller.jumpToPage(1);
//   },
//   child: Container(
//     margin: EdgeInsets.only(top: 10.sp, right: 20.sp),
//     child: Column(
//       children: [
//         Icon(Icons.shopping_bag, color: MyColors.kIconColor,),
//         Text('Offers', style: TextStyle(color: MyColors.kIconColor,),)
//
//       ],
//     ),
//   ),
// ),
//
// InkWell(
//   onTap: (){
//     controller.jumpToPage(2);
//
//
//   },
//   child: Padding(
//     padding:  EdgeInsets.only(top: 10.sp, left: 20.sp),
//     child: Column(
//       children: [
//         Expanded(
//             flex: 2,
//             child: Icon(Icons.person, color: currentIndex == 3 ? MyColors.kMainColor : MyColors.kIconColor,)),
//         Expanded(child: Text('Profile', style: TextStyle(color: currentIndex == 3 ? MyColors.kMainColor : MyColors.kIconColor,),))
//
//       ],
//     ),
//   ),
// ),
//
// InkWell(
//
//   onTap: (){
//     controller.jumpToPage(3);
//
//   },
//   child: Container(
//     margin: EdgeInsets.all(10.sp),
//     child: Column(
//       children: [
//           Expanded(
//               flex: 2,
//               child: Icon(Icons.more, color: currentIndex == 3 ? MyColors.kMainColor : MyColors.kIconColor,)),
//         Expanded(child: Text('More', style: TextStyle(color: currentIndex == 3 ? MyColors.kMainColor : MyColors.kIconColor,),))
//
//       ],
//     ),
//   ),
// ),
