import 'package:bloc/bloc.dart';


class IntroductionScreenCubit extends Cubit<int> {
  IntroductionScreenCubit(int initialState) : super(initialState);

  getIncreament({required index}){
    index++;
    emit(index);

 }
}
