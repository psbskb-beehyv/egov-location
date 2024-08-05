import 'package:country_flags/country_flags.dart';
import 'package:country_state_city/models/city.dart';
import 'package:egov/app/cubit/hide_cubit.dart';
import 'package:egov/app/cubit/location_cubit.dart';
import 'package:egov/app/cubit/min_cubit.dart';
import 'package:egov/app/handlers/common_handler.dart';
import 'package:egov/app/handlers/locations_handler.dart';
import 'package:egov/app/states/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    LocationHandler.getLocation();
    return SafeArea(
      child: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => MinCubit(),
            ),
            BlocProvider(
              create: (context) => HideCubit(),
            ),
            BlocProvider(
              create: (context) => LocationCubit()..getCities(),
            ),
          ],
          child: const HomeWidget(),
        ),
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    List<String> azList = CommonHandler.getAZList();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<HideCubit, bool>(
            builder: (context, isHide) {
              return isHide
                  ? InkWell(
                      onTap: () {
                        context.read<HideCubit>().changeState();
                        context.read<MinCubit>().changeState(false);
                      },
                      child: Container(
                        width: 50,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary),
                            color: Colors.grey[300]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BlocBuilder<HideCubit, bool>(
                              builder: (context, state) {
                                return Icon(state == true
                                    ? Icons.double_arrow
                                    : Icons.double_arrow);
                              },
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                RotatedBox(
                                  quarterTurns: -1,
                                  child: Text(
                                    'Locations',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        Text(
                          'Locations',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            BlocBuilder<MinCubit, bool>(
                              builder: (context, state) {
                                return IconButton(
                                    onPressed: () {
                                      context.read<MinCubit>().changeState();
                                    },
                                    icon: Icon(state == true
                                        ? Icons.square_outlined
                                        : Icons.minimize));
                              },
                            ),
                            BlocBuilder<HideCubit, bool>(
                              builder: (context, state) {
                                return IconButton(
                                    onPressed: () {
                                      context
                                          .read<MinCubit>()
                                          .changeState(true);
                                      context.read<HideCubit>().changeState();
                                    },
                                    icon: Icon(state == true
                                        ? Icons.double_arrow
                                        : Icons.double_arrow));
                              },
                            )
                          ],
                        ),
                      ],
                    );
            },
          ),
          BlocBuilder<MinCubit, bool>(
            builder: (context, state) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: state == true
                    ? 0
                    : (MediaQuery.of(context).size.height - 132),
                child: Column(
                  children: [
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: 'Filter Location',
                      ),
                      onChanged: (value) {
                        context.read<LocationCubit>().getCities(value);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: InkWell(
                        onTap: () {
                          searchController.clear();
                          context.read<LocationCubit>().getCities();
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.close),
                            Text('Clear All'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: Stack(
                      children: [
                        const CitiesWidget(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10)),
                            child: AZListWidget(
                                azList: azList,
                                searchController: searchController),
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AZListWidget extends StatelessWidget {
  const AZListWidget({
    super.key,
    required this.azList,
    required this.searchController,
  });

  final List<String> azList;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
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
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      searchController.text = azList[index];
                      context.read<LocationCubit>().getCities(azList[index]);
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

class CitiesWidget extends StatelessWidget {
  const CitiesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<LocationCubit, CustomState>(
        builder: (context, state) {
          if (state is DataState) {
            List<City> cities = state.data;
            return ListView.builder(
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: CountryFlag.fromCountryCode(
                          cities[index].countryCode,
                          shape: const RoundedRectangle(3),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                          '${cities[index].name} - ${cities[index].countryCode}'),
                    ],
                  );
                });
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
