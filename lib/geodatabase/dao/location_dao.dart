import 'package:dart_jts/dart_jts.dart';
import 'package:location_brazil/model/city.dart';
import 'package:flutter_geopackage/flutter_geopackage.dart';
import 'package:dart_hydrologis_db/dart_hydrologis_db.dart';
import 'package:location_brazil/geodatabase/app_geodatabase.dart';


class LocationDao {
  Future<City> getCity({required latitude, required longitude}) async {
    String nameCity = "Cidade fora do Brasil";
    final GeopackageDb gdb = await getGeoDatabase();
    Point point = GeometryFactory.defaultPrecision()
        .createPoint(Coordinate(longitude, latitude));
    List<Geometry> geometries = gdb.getGeometriesIn(
        SqlName('BR_Municipios_2019'),
        intersectionGeometry: point,
        userDataField: "NM_MUN || ' - ' || SIGLA_UF");
    if (geometries.isNotEmpty) {
      nameCity = geometries[0].userData.toString();
    }
    return City(name: nameCity);
  }
}
