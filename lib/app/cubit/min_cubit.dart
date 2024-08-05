import 'package:flutter_bloc/flutter_bloc.dart';

class MinCubit extends Cubit<bool> {
  MinCubit() : super(false);

  changeState([bool? min]) {
    emit(min ?? !state);
  }
}
