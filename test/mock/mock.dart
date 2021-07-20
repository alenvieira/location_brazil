import 'package:mockito/mockito.dart';
import 'package:location/location.dart';
import 'package:location_brazil/model/city.dart';
import 'package:location_brazil/geodatabase/dao/location_dao.dart';

class MockCity extends Mock implements City {}

class MockLocation extends Mock implements Location {}

class MockLocationDao extends Mock implements LocationDao {}