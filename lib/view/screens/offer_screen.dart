import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_monkey/constants.dart';
import 'package:meal_monkey/widgets/custom_button.dart';
import 'package:meal_monkey/widgets/my_text_fields.dart';
import 'package:ndialog/ndialog.dart';


class OfferScreen extends StatefulWidget {
  const OfferScreen({Key? key}) : super(key: key);

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
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
        title: const Text('Uploading image'),
        message: const Text('Please wait....'));

    if (imagePath == null) return;
    progressDialog.show();
    final fileName = imagePath!.path;
    final destination = 'items';
    final date = DateTime.now().microsecondsSinceEpoch;

    try {

      final ref = FirebaseStorage.instance.ref(destination).child('IMG-$date.jpg');
      await ref.putFile(imagePath!.absolute);

      url = await ref.getDownloadURL();





      progressDialog.dismiss();
    } catch (e) {
      progressDialog.dismiss();
      if (kDebugMode) {
        print('error occurred');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('offers'),

      ),
      body: Padding(
        padding:  EdgeInsets.all(10.0.sp),
        child: ListView(
          children: [

            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: Column(
                children: [
                  Expanded(child: Align(
                      alignment: Alignment.center,
                      child: imagePath == null ? Text('No image selected') : Image.file(imagePath!))),
                  Expanded(
                    flex: 0,
                    child: OutlinedButton.icon(
                      onPressed: (){
                        getImageFromGallery();

                      },
                      label: const Text('Upload image'),
                      icon: const Icon(Icons.arrow_upward),


                    ),
                  )
                  
                  
                  
                ],
              )
            ),
            SizedBox(height: 10.sp,),

            MyTextField(errorMessage: 'Please provide data', controller: titleController, hint: 'Title'),


            SizedBox(height: 20.sp,),
            CustomButton(function: ()async{


              CollectionReference ref =  FirebaseFirestore.instance.collection('popular_items');


               await ref.add({
                 'title' : titleController.text,
                 'image_url' : url
               });
               Fluttertoast.showToast(msg: 'uploaded');

            }, borderColor: Colors.transparent, label: 'Upload', buttonColor: MyColors.kMainColor, textColor: Colors.white),



          ],
        ),
      ),
      //  body: const SorryMessage()
    );
  }
}
