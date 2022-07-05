import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_monkey/view/screens/dashboard_screen.dart';

import '../../constants.dart';
import '../../controller/cubit/introduction_screen_cubit.dart';

final List<String> imagesList = [
  'assets/images/Find food you love vector.png',
  "assets/images/Delivery vector.png",
  "assets/images/Live tracking vector.png"
];

final List<String> titles = [
  'Find Food You Loved',
  'Fast Delivery',
  'Live Tracking',
];

final List<String> description = [
  'Discover the best foods from over 1,000 ',
  'Fast food delivery to your home, office ',
  'Real time tracking of your food on the app ',
];

final List<String> description2 = [
  'restaurants and fast delivery to your doorstep',
  'wherever you are',
  'once you placed the order',
];

class IntroducitonScreens extends StatefulWidget {
  const IntroducitonScreens({Key? key}) : super(key: key);

  @override
  State<IntroducitonScreens> createState() => _IntroducitonScreensState();
}

class _IntroducitonScreensState extends State<IntroducitonScreens> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IntroductionScreenCubit(0),
      child: Scaffold(
        body: BlocBuilder<IntroductionScreenCubit, int>(
          builder: (context, state) {
            return Column(
              children: [
                Spacer(flex: 1,),


                //=====================  Expanded contain Carousel slider image =============//

                Expanded(
                  flex: 7,
                  child: Container(
                    margin: EdgeInsets.only(top: 100.sp),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 500.sp,
                          autoPlay: false,
                          // enlargeCenterPage: true,
                          //scrollDirection: Axis.vertical,
                          onPageChanged: (index, reason) {


                            if (state < 2) {



                              context
                                  .read<IntroductionScreenCubit>()
                                  .getIncreament(index: state);



                            } else {
                              context
                                  .read<IntroductionScreenCubit>()
                                  .getIncreament(index: 0);


                            }


                          },
                        ),
                        items: [
                          Image.asset(
                            imagesList[state],
                          )
                        ],
                        // items: imagesList
                        //     .map(
                        //       (item) => Image.asset(
                        //         item,
                        //         fit: BoxFit.cover,
                        //         // width: double.infinity,
                        //       ),
                        //     )
                        //     .toList(),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imagesList.map((urlOfItem) {
                        int index = imagesList.indexOf(urlOfItem);
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          width: 10.0,
                          height: 10.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: state == index
                                // ? Color.fromRGBO(0, 0, 0, 0.8)
                                ? MyColors.kMainColor
                                : const Color.fromRGBO(0, 0, 0, 0.3),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              titles[state],
                              style: TextStyle(
                                  fontSize: 28.sp, color: Colors.black),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              description[state],
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: MyColors.kSecondaryFont),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              description2[state],
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: MyColors.kSecondaryFont),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                  color: Colors.transparent,
                                ),
                                primary: MyColors.kMainColor,
                                fixedSize: Size(307.sp, 56.sp),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(34.sp))),
                            onPressed: state < 2
                                ? () {

                              context.read<IntroductionScreenCubit>().getIncreament(index: state);

                                  }
                                : () {
                                    Navigator.of(context).pushReplacement(
                                        CupertinoPageRoute(builder: (context) {
                                      return const DashboardScreen();
                                    }));
                                  },
                            child: Text(
                              'Next',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.sp),
                            ),
                          ),
                        ),
                        const Spacer(
                          flex: 7,
                        )
                      ],
                    )),
              ],
            );
          },
        ),
      ),
    );
  }
}
