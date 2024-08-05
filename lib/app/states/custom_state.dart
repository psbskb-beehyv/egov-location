class CustomState {}

class LoadingState extends CustomState {}

class DataState extends CustomState {
  final dynamic data;

  DataState({required this.data});
}
