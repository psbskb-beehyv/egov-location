import 'package:flutter_bloc/flutter_bloc.dart';

class HideCubit extends Cubit<bool> {
  HideCubit() : super(false);

  changeState([bool? hide]) {
    emit(hide ?? !state);
  }
}
