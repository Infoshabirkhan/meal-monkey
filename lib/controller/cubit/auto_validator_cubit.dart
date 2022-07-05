import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


class AutoValidatorCubit extends Cubit<bool> {
  AutoValidatorCubit(bool initialState) : super(initialState);


  autoValidation({required enable}){
    emit(enable);
  }
}
