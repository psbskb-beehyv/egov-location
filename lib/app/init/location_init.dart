import 'package:country_state_city/models/city.dart';
import 'package:country_state_city/utils/utils.dart';

class LocationInit {
  static final LocationInit _instance = LocationInit._();
  LocationInit._();
  static LocationInit get instance => _instance;

  List<City> cities = [];
  Future<void> init() async {
    List<City> allCities = await getAllCities();
    List<City> subCities = allCities.sublist(0, 10000);
    subCities.sort((a, b) => a.name.compareTo(b.name));
    cities = subCities;
    return;
  }
}
