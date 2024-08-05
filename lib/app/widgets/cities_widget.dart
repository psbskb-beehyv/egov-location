import 'package:country_flags/country_flags.dart';
import 'package:country_state_city/models/city.dart';
import 'package:flutter/widgets.dart';

class CitiesWidget extends StatelessWidget {
  final List<City> cities;
  final ScrollController scrollController;
  const CitiesWidget({
    super.key,
    required this.scrollController,
    required this.cities,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: scrollController,
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 40,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: CountryFlag.fromCountryCode(
                    cities[index].countryCode,
                    shape: const RoundedRectangle(3),
                  ),
                ),
                const SizedBox(width: 8),
                Text('${cities[index].name} - ${cities[index].countryCode}'),
              ],
            ),
          );
        });
  }
}
