import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SorryMessage extends StatelessWidget {
  const SorryMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Sorry For that',
            style: TextStyle(color: Colors.orange, fontSize: 18.sp),
          ),
          Text(
            'We will Fixed it soon',
            style: TextStyle(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
