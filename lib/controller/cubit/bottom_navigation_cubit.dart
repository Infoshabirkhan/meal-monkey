import 'package:bloc/bloc.dart';


class BottomNavigationCubit extends Cubit<int> {
  BottomNavigationCubit(int initialState) : super(initialState);


  getIndex({required index}){
    emit(index);
  }
}
