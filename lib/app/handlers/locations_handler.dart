import 'package:country_state_city/models/city.dart';
import 'package:country_state_city/utils/utils.dart';

class LocationHandler {
  static Future<List<City>> getLocation([String? name]) async {
    List<City> cities = await getAllCities();
    List<City> subCities = cities.sublist(0, 500);
    List<City> filterCities = [];
    for (var city in subCities) {
      if (name != null && name != "") {
        if (name.toLowerCase() == city.name.toLowerCase()) {
          filterCities.add(city);
        } else if (_canAdd(name, city)) {
          filterCities.add(city);
        }
      } else {
        filterCities.add(city);
      }
    }
    return filterCities;
  }

  static bool _canAdd(String name, city) {
    bool canAdd = false;
    for (var i = 0; i < name.length; i++) {
      if (name[i].toLowerCase() == city.name[i].toLowerCase()) {
        canAdd = true;
      } else {
        canAdd = false;
        return false;
      }
    }
    return canAdd;
  }
}
