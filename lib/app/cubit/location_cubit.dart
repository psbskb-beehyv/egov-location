import 'package:country_state_city/models/city.dart';
import 'package:egov/app/handlers/locations_handler.dart';
import 'package:egov/app/states/custom_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationCubit extends Cubit<CustomState> {
  LocationCubit() : super(LoadingState());

  getCities([String? name]) async {
    emit(LoadingState());
    List<City> cities = await LocationHandler.getLocation(name);
    final Iterable<City> foo = List.unmodifiable(cities);
    emit(DataState(data: foo.toList()));
  }
}
