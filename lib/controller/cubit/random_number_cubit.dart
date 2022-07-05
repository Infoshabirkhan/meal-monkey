import 'dart:math';

import 'package:bloc/bloc.dart';


class RandomNumberCubit extends Cubit<double> {
  RandomNumberCubit(double initialState) : super(initialState);


  getNewRandom({required number}){
    var random = Random();
    number = random.nextInt(100).toDouble();
    emit(number);
  }
}
