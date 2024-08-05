import 'package:egov/app/init/location_init.dart';

class AppInit {
  static Future<void> init() async {
    return await LocationInit.instance.init();
  }
}
