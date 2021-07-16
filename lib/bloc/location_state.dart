import 'package:location_brazil/model/city.dart';

abstract class LocationState{}

class InitialState implements LocationState {
  const InitialState();
}

class ProcessingState implements LocationState {
  const ProcessingState();
}

class ErrorState implements LocationState {
  final dynamic error;
  const ErrorState(this.error);
}

class SuccessState implements LocationState {
  final City city;
  const SuccessState(this.city);
}