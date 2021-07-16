// @dart=2.11
import 'package:mockito/mockito.dart';
import 'package:location/location.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location_brazil/bloc/location_bloc.dart';
import 'package:location_brazil/bloc/location_state.dart';
import 'package:location_brazil/model/city.dart';

import '../mock/mock.dart';

void main() {
  final dao = MockLocationDao();
  final location = MockLocation();
  final bloc = LocationBloc(dao, location);

  group('tests DAO', () {
    test('Should return City when called getCity in DAO', () async {
      when(dao.getCity(latitude: -15.7801, longitude: -47.9292))
          .thenAnswer((_) async => City(name: 'Brasília'));
      City city = await dao.getCity(latitude: -15.7801, longitude: -47.9292);
      verify(dao.getCity(latitude: -15.7801, longitude: -47.9292)).called(1);
      expect(city.name, 'Brasília');
    });
  });

  group('tests BLOC', () {
    test(
        'Should return order state (ProcessingState, SucessState) when event process add in bloc',
        () async {
      when(location.getLocation()).thenAnswer((_) async =>
          LocationData.fromMap({'latitude': -15.7801, 'longitude': -47.9292}));
      when(dao.getCity(latitude: -15.7801, longitude: -47.9292))
          .thenAnswer((_) async => City(name: 'Brasília'));
      bloc.add(LocationEvent.process);
      await expectLater(bloc.stream,
          emitsInOrder([isA<ProcessingState>(), isA<SuccessState>()]));
    });

    test(
        'Should return order state(ProcessingState, ErrorState) when exception in location',
        () async {
      when(location.getLocation()).thenThrow(Exception('Error'));

      bloc.add(LocationEvent.process);

      await expectLater(bloc.stream,
          emitsInOrder([isA<ProcessingState>(), isA<ErrorState>()]));
    });

    test(
        'Should return order state(ProcessingState, ErrorState) when exception in dao',
        () async {
      when(location.getLocation()).thenAnswer((_) async =>
          LocationData.fromMap({'latitude': -15.7801, 'longitude': -47.9292}));
      when(dao.getCity(latitude: -15.7801, longitude: -47.9292))
          .thenThrow(Exception('Error'));
      bloc.add(LocationEvent.process);
      await expectLater(bloc.stream,
          emitsInOrder([isA<ProcessingState>(), isA<ErrorState>()]));
    });
  });
}
