import 'package:country_state_city/models/city.dart';
import 'package:country_state_city/utils/utils.dart';

class LocationInit {
  static final LocationInit _instance = LocationInit._();
  LocationInit._();
  static LocationInit get instance => _instance;

  List<City> cities = [];
  Future<void> init() async {
    cities = await getAllCities();
    return;
  }
}
