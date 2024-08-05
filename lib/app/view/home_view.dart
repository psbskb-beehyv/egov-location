import 'package:country_state_city/models/city.dart';
import 'package:egov/app/cubit/hide_cubit.dart';
import 'package:egov/app/cubit/location_cubit.dart';
import 'package:egov/app/cubit/min_cubit.dart';
import 'package:egov/app/handlers/common_handler.dart';
import 'package:egov/app/handlers/locations_handler.dart';
import 'package:egov/app/states/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/az_list_widget.dart';
import '../widgets/cities_widget.dart';

TextEditingController searchController = TextEditingController();
final ScrollController scrollController = ScrollController();
List<String> azList = CommonHandler.getAZList();

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
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LocationControllsWidget(),
          CitiesWithAZWidget(),
        ],
      ),
    );
  }
}

class LocationControllsWidget extends StatelessWidget {
  const LocationControllsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HideCubit, bool>(
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
                      color: Theme.of(context).colorScheme.primaryContainer),
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
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          RotatedBox(
                            quarterTurns: -1,
                            child: Text(
                              'Locations',
                              style: Theme.of(context).textTheme.titleLarge,
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
                                context.read<MinCubit>().changeState(true);
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
    );
  }
}

class CitiesWithAZWidget extends StatelessWidget {
  const CitiesWithAZWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MinCubit, bool>(
      builder: (context, state) {
        return state == true
            ? Container()
            : Expanded(
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
                    BlocBuilder<LocationCubit, CustomState>(
                      builder: (context, state) {
                        if (state is DataState) {
                          List<City> cities = state.data;
                          return Expanded(
                              child: Stack(
                            children: [
                              CitiesWidget(
                                scrollController: scrollController,
                                cities: cities,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: AZListWidget(
                                    azList: azList,
                                    cities: cities,
                                    searchController: searchController,
                                    scrollController: scrollController,
                                  ),
                                ),
                              ),
                            ],
                          ));
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    )
                  ],
                ),
              );
      },
    );
  }
}
