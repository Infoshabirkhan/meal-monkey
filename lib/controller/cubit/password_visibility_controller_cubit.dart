import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


class PasswordVisibilityControllerCubit extends Cubit<bool> {
  PasswordVisibilityControllerCubit(initialState) : super(initialState);

  passwordVisibility({required visible}){
    emit(visible);
  }

}
