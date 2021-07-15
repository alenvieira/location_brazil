import 'package:flutter_test/flutter_test.dart';
import 'package:location_brazil/model/city.dart';

void main() {
  test('Should return the name when create a city', () {
    final City city = City(name: 'Brasília');
    expect(city.name, 'Brasília');
  });
}
