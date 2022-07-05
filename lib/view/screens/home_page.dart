import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_monkey/models/data_store.dart';

import '../../constants.dart';
import '../../widgets/recent_dashboard_items.dart';

var items = [
  'Peshawar',
  'Mardan',
  'Nowshera',
  'Swabi',
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropdownValue = 'Current location';
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Current Location"),value: "Current Location"),
      const DropdownMenuItem(child: Text("Peshawar"),value: "peshawar"),
      const DropdownMenuItem(child: Text("Nowshera"),value: "Nowshera"),
      const DropdownMenuItem(child: Text("Mardan"),value: "Mardan"),
    ];
    return menuItems;
  }
  String selectedValue = "Current Location";



  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(physics: const BouncingScrollPhysics(), children: [
        SizedBox(
          height: 30.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 21.sp, right: 21.sp),
          child: SizedBox(
            height: 0.25.sh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text(
                            'Good Morning Alika!',
                            style: TextStyle(fontSize: 20.sp),
                          )),
                      Expanded(
                          child: Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.shopping_cart),
                        ),
                      ))
                    ],
                  ),
                ),

                const Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Delivering to',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ),

                //  ----------------- Drop Down button ------------------       //

                Expanded(
                  flex: 2,
                    child: Container(
                  alignment: Alignment.topLeft,
                  child: DropdownButton(
                      underline: Container(
                        alignment: Alignment.topLeft,
                        color: Colors.black,
                      ),
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: MyColors.kMainColor,
                      ),
                      value: selectedValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                      items: dropdownItems),
                )),

                //  ----------------- Drop down ends here ------------------       //

                //  -------------- Search field ------------------       //


                Expanded(
                  flex: 2,
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(28.sp)),
                        fillColor: MyColors.kTextField,
                        prefixIcon: Icon(
                          CupertinoIcons.search,
                          color: MyColors.kSecondaryFont,
                        ),
                        hintText: 'Search food',
                        filled: true,
                        hintStyle: TextStyle(color: MyColors.kSecondaryFont)),
                  ),
                ),
                const Spacer(
                  flex: 1
                ),
              ],
            ),
          ),
        ),

        //  ----------------- Menus start here ------------------       //
        //  -----------------First horizental scrolling  ------------------       //

        //   horizental scrolling menus
        Padding(
          padding: EdgeInsets.only(left: 21.sp),
          child: SizedBox(
            height: 100.h,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                primary: false,
                itemCount: DataStore().menu.length,
                itemBuilder: (BuildContext context, int index) {
                  var menu = DataStore().menu[index];
                  return getItems(image: menu.image, title: menu.title);
                }),
          ),
        ),

        //  ----------------- Menus ends here------------------       //

        //  -----------------Popular restaurants start here ------------------       //

        SizedBox(height: 20.sp,),
        Padding(
          padding: EdgeInsets.only(left: 21.sp),
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Text(
                    'Popular Restaurants',
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  )),
              Expanded(
                  child: TextButton(
                      style: TextButton.styleFrom(primary: MyColors.kMainColor),
                      onPressed: () {},
                      child: const Text('View All')))
            ],
          ),
        ),

        //          LIst view builder      //

        ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: DataStore().popularRestaurants.length,
            itemBuilder: (BuildContext context, int index) {
              var menu = DataStore().popularRestaurants[index];
              return getMenus(image: menu.image, title: menu.title);
            }),

        //  ----------------- Popular resturants ends here ------------------       //

        //  ----------------- Most Popular start here------------------       //
        Padding(
          padding: EdgeInsets.only(left: 21.sp, bottom: 21.sp, top: 31.sp),
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Text(
                    'Most Popular',
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  )),
              Expanded(
                  child: TextButton(
                      style: TextButton.styleFrom(primary: MyColors.kMainColor),
                      onPressed: () {},
                      child: const Text('View All')))
            ],
          ),
        ),

        //    List view builder   //

        Padding(
          padding: EdgeInsets.only(left: 21.sp),
          child: SizedBox(
            height: 200.h,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                primary: false,
                itemCount: DataStore().mostPolular.length,
                itemBuilder: (BuildContext context, int index) {
                  var mostPopular = DataStore().mostPolular[index];

                  return geMostPopularItems(
                      image: mostPopular.image, title: mostPopular.title);
                }),
          ),
        ),

        //  ----------------- Most Popular ends here ------------------       //

        //  -----------------Recent items starts here -------------       //
        Padding(
          padding: EdgeInsets.only(left: 21.sp, bottom: 21.sp),
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Text(
                    'Recent Items',
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  )),
              Expanded(
                  child: TextButton(
                      style: TextButton.styleFrom(primary: MyColors.kMainColor),
                      onPressed: () {},
                      child: const Text('View All')))
            ],
          ),
        ),

        ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: DataStore().recentItem.length,
            itemBuilder: (BuildContext context, int index) {
              var recent = DataStore().recentItem[index];
              return RecentDashboardItems(
                  image: recent.image, title: recent.title);
            }),
      ]),

      // ----------------- Menus function -------------       //

      //  -----------------Recent items ends here -------------       //



    );
  }
}




Widget getItems({required String image, required String title}) {
  return Container(
      margin: EdgeInsets.only(right: 18.sp),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Image.asset(
              "assets/images/items/" + image,
              width: 85.sp,
            ),
          ),
          // SizedBox(
          //   height: 5.sp,
          // ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              // color: Colors.blue,
              child: Text(
                title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ));
}

//  -----------------ending  -------------       //




//  -----------------Popular restaurants function starts here -------------       //

Widget getMenus({
  required String image,
  required String title,
}) {
  return Container(
    height: 200.sp,
    // color: Colors.blue,
    margin: EdgeInsets.only(top: 31.sp),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 9,
          child: SizedBox(
            width: 1.sw,
            child: Image.asset(
              "assets/images/" + image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.only(left: 21.sp, top: 7.sp, bottom: 5.sp),
            child: Text(
              title,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 21.sp),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.star,
                          color: MyColors.kMainColor,
                        ))),
                Expanded(
                    child: Text(
                  '4.9',
                  style: TextStyle(color: MyColors.kMainColor),
                )),
                Expanded(
                    flex: 8,
                    child: Text(
                      '(124 ratings) Café     Western Food',
                      style: TextStyle(color: MyColors.kSecondaryFont),
                    )),
                Expanded(child: Container())
              ],
            ),
          ),
        )
      ],
    ),
  );
}
//  -----------------Popular restaurants function ends here -------------       //




//  -----------------most popular function starts here -------------       //


Widget geMostPopularItems({required String image, required String title}){
  return Container(
//                  color: Colors.blue,
    margin: EdgeInsets.only(right: 19.sp),
    width: 0.5.sw,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 3,
            child:
            Image.asset("assets/images/items/"+ image)),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: 7.sp,
            ),
            child: Text(
              title,
              style: TextStyle(fontSize: 18.sp),
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                const Expanded(
                    flex: 3,
                    child: Text(
                      'Café     Western Food',
                    )),
                Expanded(
                    child: Icon(
                      Icons.star,
                      color: MyColors.kMainColor,
                    )),
                Expanded(
                    child: Text(
                      '4.9',
                      style: TextStyle(color: MyColors.kMainColor),
                    ))
              ],
            ),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    ),
  );
}


//  -----------------most popular function ends here -------------       //



// body: ListView(
//   children: [
//     Container(
//       color: Colors.blue,
//       // child: StreamBuilder(
//       //   stream: FirebaseFirestore.instance.collection('categories').doc('vZeuGvqqxtLSwTn3FpG5').collection('popular_items').snapshots(),
//       //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
//       //
//       //
//       //     if(snapshot.hasData){
//       //       print('=================');
//       //       print(snapshot.data!.docs.length);
//       //
//       //
//       //       return ListView.builder(
//       //         physics: BouncingScrollPhysics(),
//       //
//       //         shrinkWrap: true,
//       //           primary: false,
//       //
//       //           itemCount: snapshot.data!.docs.length,
//       //           itemBuilder: (context, index) {
//       //             var data = snapshot.data!.docs[index];
//       //         return Column(
//       //           children: [
//       //
//       //             Center(child: Text(data['title']),),
//       //
//       //           Image.network(data['image_url'])
//       //           ],
//       //         );
//       //       });
//       //
//       //
//       //
//       //
//       //     }else{
//       //       return Center(child: Text(''),);
//       //     }
//       //   },
//       // ),
//
//     ),
//
//
//     Container(
//       height: 100,
//       color: Colors.red,
//       child: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('popular_items').snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
//
//
//           if(snapshot.hasData){
//             print('=================');
//             print(snapshot.data!.docs.length);
//
//
//             return ListView.builder(
//               scrollDirection: Axis.horizontal,
//                 physics: BouncingScrollPhysics(),
//
//                 shrinkWrap: true,
//                 primary: false,
//
//                 itemCount: snapshot.data!.docs.length,
//                 itemBuilder: (context, index) {
//                   var data = snapshot.data!.docs[index];
//                 return getItems(image: data['image_url'], title: data['title']);
//                 });
//
//
//
//
//           }else{
//             return Center(child: Text(''),);
//           }
//         },
//       ),
//
//     )
//
//
//   ],
// ),



