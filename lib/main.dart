// @dart=2.11
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:location_brazil/bloc/bloc_provider.dart';
import 'package:location_brazil/bloc/location_bloc.dart';
import 'package:location_brazil/geodatabase/app_geodatabase.dart';
import 'package:location_brazil/geodatabase/dao/location_dao.dart';
import 'package:location_brazil/screen/location_screen.dart';

void main() {
  runApp(LocationApp());
}

class LocationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green.shade900,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.green.shade900,

          ),
        ),
      ),
      home: BlocProvider(
          bloc: LocationBloc(LocationDao(), Location()),
      child: LocationPage(),
    ),);
  }
}
