import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_geopackage/flutter_geopackage.dart';

const String _filenameGeodatabase = 'BR_Municipios_2019.gpkg';

Future<GeopackageDb> getGeoDatabase() async {
  Directory directory = await getApplicationSupportDirectory();
  File file =
      File('${directory.path}${Platform.pathSeparator}$_filenameGeodatabase');
  if (!file.existsSync()) {
    ByteData data = await rootBundle
        .load('geodatabase${Platform.pathSeparator}$_filenameGeodatabase');
    file = await File(
            '${directory.path}${Platform.pathSeparator}$_filenameGeodatabase')
        .writeAsBytes(
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
  GeopackageDb vectorDb = ConnectionsHandler().open(file.path);
  vectorDb.openOrCreate();
  return vectorDb;
}
