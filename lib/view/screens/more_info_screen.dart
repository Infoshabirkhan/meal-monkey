
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/cubit/random_number_cubit.dart';
import '../../widgets/bouncing_page_transition.dart';
import '../../widgets/sorry_message.dart';
import 'landing_screen.dart';

class MoreInfoScreen extends StatefulWidget {
  const MoreInfoScreen({Key? key}) : super(key: key);

  @override
  State<MoreInfoScreen> createState() => _MoreInfoScreenState();
}

class _MoreInfoScreenState extends State<MoreInfoScreen> {
  double width = 50;

  double height = 50;

  @override
  Widget build(BuildContext context) {
    
    
    
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData){
            print(snapshot.data);

            var data = snapshot.data!.docs ;

            return ListView.builder(

                itemCount: data.length,
                itemBuilder: (context, index){

                  var orders = data[index];
              return Container(
                padding: EdgeInsets.all(30),
                child: InkWell(
                  onTap: ()async{

                    print(orders.id);
                    FirebaseFirestore.instance.collection('orders').doc(orders.id).update(
                        {
                          'request_status' : 'accepted'
                        }).whenComplete(() => print('done'));

                  },
                  child: Row(children: [
            Expanded(child: Text('${orders['name']}')),
                    Expanded(child: Text('${orders['request_status']}')),

                  ],),
                ),
              );
            });

          }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
    
    
    // return BlocProvider(
    //   create: (context) => RandomNumberCubit(50),
    //   child: Scaffold(
    //     appBar: AppBar(
    //       elevation: 0,
    //       backgroundColor: Colors.white,
    //       title: const Text('More info'),
    //     ),
    //
    //
    //
    //     body: Column(
    //       children: [
    //         const Expanded(
    //             flex: 2,
    //             child: SorryMessage()),
    //
    //
    //
    //         Expanded(
    //           child: TextButton(onPressed: ()async{
    //
    //
    //             await FirebaseAuth.instance.signOut();
    //
    //             Navigator.of(context).pushReplacement(BouncingPageTransition(const LandingScreen()));
    //
    //             // Navigator.of(context).pushReplacement(
    //             //     MaterialPageRoute(builder: (context) {
    //             //       return const LandingScreen();
    //             //     }));
    //           }, child: const Text('Yes' , style: TextStyle( color: Colors  .transparent),),),
    //         ),
    //
    //       ],
    //     )
    //   ),
    // );
  }
}



// body: SizedBox(
//   height: double.infinity,
//   width: double.infinity,
//   child: Column(
//     children: [
//       AnimatedContainer(
//         curve: Curves.easeInOut,
//         height: height,
//         width: width,
//         color: Colors.blue,
//         duration: Duration(seconds: 2),
//       ),
//       ElevatedButton(
//           onPressed: () {
//             var random = Random();
//
//             width = random.nextInt(200).toDouble();
//             height = Random().nextInt(200).toDouble();
//             setState(() {});
//           },
//           child: const Text('Animate')),
//     ],
//   ),
// ),
