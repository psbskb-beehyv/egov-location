import 'package:country_state_city/models/city.dart';
import 'package:flutter/material.dart';

class AZListWidget extends StatelessWidget {
  const AZListWidget({
    super.key,
    required this.azList,
    required this.cities,
    required this.searchController,
    required this.scrollController,
  });

  final List<String> azList;
  final List<City> cities;
  final TextEditingController searchController;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    void animateToIndex(int index) {
      scrollController.animateTo(
        index * 40,
        duration: const Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: SizedBox(
        width: 40,
        child: ListView.builder(
            itemCount: azList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Center(
                child: MaterialButton(
                    minWidth: 40,
                    height: 40,
                    elevation: 0,
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      int i = (cities.indexWhere((element) {
                        return (element.name[0].toLowerCase() == azList[index]);
                      }));
                      animateToIndex(i < 0 ? 0 : i);
                    },
                    child: Text(
                      azList[index],
                    )),
              );
            }),
      ),
    );
  }
}
