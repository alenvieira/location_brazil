import 'package:bloc/bloc.dart';
import 'package:location/location.dart';
import 'package:location_brazil/model/city.dart';
import 'package:location_brazil/bloc/location_state.dart';
import 'package:location_brazil/geodatabase/dao/location_dao.dart';

enum LocationEvent { initial, process }

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationDao dao;
  final Location location;

  LocationBloc(this.dao, this.location) : super(const InitialState());

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    if (event == LocationEvent.initial) {
      yield InitialState();
    } else if (event == LocationEvent.process) {
      yield ProcessingState();
      try {
        final LocationData _locationResult = await location.getLocation();
        City city = await dao.getCity(
            latitude: _locationResult.latitude,
            longitude: _locationResult.longitude);
        yield SuccessState(city);
      } catch (error) {
        yield ErrorState(error);
      }
    }
  }
}
