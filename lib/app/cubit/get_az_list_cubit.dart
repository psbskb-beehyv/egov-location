import 'package:egov/app/handlers/common_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AZListCubit extends Cubit<List<String>> {
  AZListCubit() : super([]);
  getList([String? text]) {
    List<String> azList = [];
    if (text != null && text.isNotEmpty) {
      azList = [text[0]];
    } else {
      azList = CommonHandler.getAZList();
    }
    emit(azList);
  }
}
