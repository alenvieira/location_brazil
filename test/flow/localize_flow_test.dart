// @dart=2.11
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location_brazil/model/city.dart';

import '../mock/mock.dart';

void main() {
  final dao = MockLocationDao();

  group('tests DAO', () {
    test('Should return City when called getCity in DAO', () async {
      when(dao.getCity(latitude: -15.7801, longitude: -47.9292))
          .thenAnswer((_) async => City(name: 'Brasília'));
      City city = await dao.getCity(latitude: -15.7801, longitude: -47.9292);
      verify(dao.getCity(latitude: -15.7801, longitude: -47.9292)).called(1);
      expect(city.name, 'Brasília');
    });
  });
}
