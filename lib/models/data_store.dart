
import 'package:meal_monkey/models/popular_items_model.dart';

class DataStore{


  var menu = <PopularItemsModel>[

    PopularItemsModel(image: '1.png', title: 'offers'),
    PopularItemsModel(image: '2.png', title: 'Sri Lankan'),
    PopularItemsModel(image: '3.png', title: 'italian'),
    PopularItemsModel(image: '4.png', title: 'indian'),
  ];

    var popularRestaurants = <PopularItemsModel>[

    PopularItemsModel(image: 'meal_1.png', title: 'Minute by tuk tuk', ),
     PopularItemsModel(image: 'meal_2.png', title: 'Café de Noir',),
     PopularItemsModel(image: 'meal_3.png', title: 'Bakes by Tella',),


   ];


    var mostPolular = <PopularItemsModel>[


      PopularItemsModel(image: 'unsplash.png', title: 'Café De Bambaa'),
      PopularItemsModel(image: 'unsplash_1.png', title: 'Burger by Bella'),
    ];


    var recentItem = <PopularItemsModel>[

      PopularItemsModel(image: 'recent_1.png', title: 'Mulberry Pizza by Josh'),
      PopularItemsModel(image: 'recent_2.png', title: 'Barita'),
      PopularItemsModel(image: 'recent_3.png', title: 'Pizza Rush Hour'),


    ];



}