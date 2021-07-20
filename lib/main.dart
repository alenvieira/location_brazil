// @dart=2.11
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:location_brazil/bloc/bloc_provider.dart';
import 'package:location_brazil/bloc/location_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:location_brazil/screen/location_screen.dart';
import 'package:location_brazil/geodatabase/dao/location_dao.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];
  runApp(
    EasyLocalization(
      saveLocale: false,
      supportedLocales: [
        Locale.fromSubtags(languageCode: 'pt'),
        Locale.fromSubtags(languageCode: 'en'),
      ],
      useFallbackTranslations: true,
      fallbackLocale: Locale.fromSubtags(languageCode: 'en'),
      path: 'assets/translations',
      child: LocationApp(),
    ),
  );
}

class LocationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
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
      ),
    );
  }
}
