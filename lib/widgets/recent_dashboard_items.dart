import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

class RecentDashboardItems extends StatelessWidget {
  final String image;
  final String title;

  const RecentDashboardItems(
      {Key? key, required this.title, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.sp, left: 21.sp, right: 21.sp),
      child: Row(
        children: [
          Expanded(
              child: Container(
            alignment: Alignment.topLeft,
            height: 60.h,
            child: Image.asset(
              "assets/images/items/" + image,
              fit: BoxFit.cover,
            ),
          )),
          Expanded(
              flex: 3,
              child: SizedBox(
                  height: 60.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(
                        title,
                        style: TextStyle(fontSize: 18.sp),
                      )),
                      Expanded(
                          child: Text('Café     Western Food',
                              style: TextStyle(
                                  color: MyColors.kSecondaryFont,
                                  fontSize: 11.sp))),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(Icons.star,
                                        color: MyColors.kMainColor))),
                            Expanded(
                                flex: 5,
                                child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '(124) Ratings',
                                      style: TextStyle(
                                          color: MyColors.kSecondaryFont,
                                          fontSize: 11.sp),
                                    ))),
                          ],
                        ),
                      )
                    ],
                  )))
        ],
      ),
    );
  }
}
