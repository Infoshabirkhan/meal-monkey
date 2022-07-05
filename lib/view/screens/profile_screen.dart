import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_monkey/constants.dart';
import 'package:meal_monkey/controller/page_controller.dart';
import 'package:meal_monkey/widgets/bouncing_page_transition.dart';
import 'package:ndialog/ndialog.dart';

import 'landing_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? url;
  File? localFile;

  bool localFileStatus = false;
  File? imagePath;
  String imageName = '';

  Future getImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    imagePath = File(image.path);

    localFileStatus = true;

    localFile = imagePath;

    setState(() {});
    uploadFile();
  }

  Future uploadFile() async {
    ProgressDialog progressDialog = ProgressDialog((context),
        title: const Text('Updating your profile..'),
        message: const Text('Please wait....'));

    if (imagePath == null) return;
    progressDialog.show();
    final fileName = imagePath!.path;
   // final destination = 'files/$fileName';

    final destination = 'Users_Profile_images';
    try {

      final ref = FirebaseStorage.instance.ref(destination).child('IMG-${user!.uid}');
      await ref.putFile(imagePath!.absolute);

      url = await ref.getDownloadURL();


      FirebaseFirestore.instance.collection('users').doc(user!.uid).update(
          {
            'profile_image' : url
          }).then((value) => Fluttertoast.showToast(msg: 'Profile picture updated'));

      if (kDebugMode) {
        print(url);
      }



      progressDialog.dismiss();
    } catch (e) {
      progressDialog.dismiss();
      if (kDebugMode) {
        print('error occurred');
      }
    }
  }

  User? user;


  @override
  void initState() {
    // TODO: implement initState

    user = FirebaseAuth.instance.currentUser;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  Firestore users detial

    return Scaffold(

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('Loading...'));
          }
          if(snapshot.hasError){
            return const Center(child: Text('Something went wrong'),);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {

            var data = snapshot.data!;
            return Container(
              padding: EdgeInsets.only(left: 30.sp, right: 30.sp),
              height: 0.8.sh,
              child: Column(

                children: [
                  const Spacer(flex: 2,),

                  Align(
                      alignment: Alignment.topRight,
                      child: OutlinedButton.icon(onPressed: (){

                        showDialog(
                            context: (context),
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Confirmation!!!'),
                                content: const Text('Are you sure to logout'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('N0')),
                                  TextButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();

                                        await FirebaseAuth.instance.signOut();

                                        Navigator.of(context).pushReplacement(
                                            BouncingPageTransition(
                                                const LandingScreen()));


                                      },
                                      child: const Text('Yes')),
                                ],
                              );
                            });

                      }, label: const Text('log out', ), icon: const Icon(Icons.logout),)),

                  const Spacer(),
                  Expanded(
                    flex: 4,
                    child: Container(

                      decoration: const BoxDecoration(


                          // shape: BoxShape.circle
                          ),
                      child: Stack(
                        children: [

                          CircleAvatar(
                            radius: 70.sp,
                            backgroundImage: data['profile_image'] == ''
                                ? localFileStatus
                                    ? FileImage(localFile!) as ImageProvider

                                    : const AssetImage(
                                        'assets/images/download.jpg')
                                : NetworkImage(data['profile_image']),

                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.sp),
                                    color: Colors.black.withOpacity(0.7)),
                                child: IconButton(
                                    onPressed: () async {

                                      await getImageFromGallery();

                                    },
                                    icon:  Icon(Icons.camera_alt, color: MyColors.kMainColor,))),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        data['Name'],
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: Row(
                      children: [
                        const Expanded(child: Text('Email')),
                        Expanded(
                            child:
                                Text(data['email'])),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    flex: 7,
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Row(
                        children: [
                          const Expanded(child: Text('Address')),
                          Expanded(child: Text(data['address'])),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );


  }
}








// return SizedBox(
//   height: 1.sh,
//   child: StreamBuilder<QuerySnapshot>(
//     stream: _usersStream,
//     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//       if (snapshot.hasError) {
//         return const Text('Something went wrong');
//       } else if (snapshot.connectionState == ConnectionState.waiting) {
//         return const Text("Loading");
//       } else if (snapshot.hasData) {
//         return ListView(
//           children: snapshot.data!.docs.map((DocumentSnapshot document) {
//             Map<String, dynamic> data =
//                 document.data()! as Map<String, dynamic>;
//
//             return InkWell(
//
//               child: Visibility(
//                 visible: user!.uid == data['uid'] ? true : false,
//                 child: Padding(
//                   padding: EdgeInsets.all(20.0.sp),
//                   child: SizedBox(
//                     height: 500.h,
//                     child:
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//         );
//       } else {
//         return const CircularProgressIndicator();
//       }
//     },
//   ),
// );

// return Scaffold(
//
//     appBar: AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       title: const Text('Profile'),
//
//     ),
//     body: Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           CustomButton(function: ()async{
//
//             await FirebaseAuth.instance.signOut();
//             Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
//
//               return const LandingScreen();
//             }));
//
//
//           }, borderColor: MyColors.kMainColor, label: 'Log out ', buttonColor: MyColors.kMainColor, textColor: Colors.white)
//         ],
//       ),
//     )
// );

//  Firestore users detial

// return StreamBuilder<QuerySnapshot>(
//   stream: _usersStream,
//   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//     print('====================================');
//     print(_usersStream.length);
//     if (snapshot.hasError) {
//       print(_usersStream.length);
//
//       return Text('Something went wrong');
//     }
//
//     else if (snapshot.connectionState == ConnectionState.waiting) {
//       print(_usersStream.length);
//
//       return Text("Loading");
//     }
//
//     else if (snapshot.hasData){
//       print(_usersStream.length);
//
//       return ListView(
//         children: snapshot.data!.docs.map((DocumentSnapshot document) {
//           Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
//           return Visibility(
//             visible: user!.uid == user!.uid ? true: false ,
//             child: ListTile(
//               title: Text(data['Name']),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(data['email'] == '' ? '' : data['email']),
//                   Text(data['address']),
//
//                   Divider()
//                 ],
//               ),
//             ),
//           );
//         }).toList(),
//       );
//
//
//
//
//     }else{
//       return CircularProgressIndicator();
//     }
//
//   },
// );
