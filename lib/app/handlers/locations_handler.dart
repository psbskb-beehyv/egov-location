import 'package:country_state_city/models/city.dart';
import 'package:egov/app/init/location_init.dart';

class LocationHandler {
  static Future<List<City>> getLocation([String? name]) async {
    List<City> cities = LocationInit.instance.cities;
    List<City> filterCities = [];
    for (var city in cities) {
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

  static bool _canAdd(String name, City city) {
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
