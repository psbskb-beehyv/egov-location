import 'package:country_state_city/models/city.dart';
import 'package:egov/app/handlers/common_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AZListCubit extends Cubit<List<String>> {
  AZListCubit() : super([]);
  getList([List<City> cities = const [], String? text]) {
    List<String> azList = [];
    if (text != null && text.isNotEmpty) {
      azList = [text[0]];
    } else {
      if (cities.isEmpty) {
        azList = CommonHandler.getAZList();
      } else {
        for (var e in CommonHandler.getAZList()) {
          if (cities.indexWhere(
                  (element) => (element.name[0].toLowerCase() == e)) !=
              -1) {
            azList.add(e);
          }
        }
      }
    }
    emit(azList);
  }
}
