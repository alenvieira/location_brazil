// @dart=2.11
import '../mock/mock.dart';
import 'package:flutter/material.dart';
import 'package:location_brazil/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location_brazil/bloc/bloc_provider.dart';
import 'package:location_brazil/bloc/location_bloc.dart';
import 'package:location_brazil/screen/location_screen.dart';
import 'package:easy_localization/easy_localization.dart';

void main() {
  final dao = MockLocationDao();
  final location = MockLocation();
  final bloc = LocationBloc(dao, location);
  EasyLocalization.logger.enableBuildModes = [];

  final screen = MaterialApp(
      home: BlocProvider(
    bloc: bloc,
    child: LocationPage(),
  ));

  testWidgets('Should display image when open app',
      (WidgetTester tester) async {
    await tester.pumpWidget(screen);
    final image = find.byType(Image);
    expect(image, findsOneWidget);
  });

  testWidgets('Should display button when open app',
      (WidgetTester tester) async {
    await tester.pumpWidget(screen);
    final button = find.byType(ElevatedButton);
    expect(button, findsOneWidget);
  });

  testWidgets('Should display tree text when open app',
      (WidgetTester tester) async {
    await tester.pumpWidget(screen);
    final text = find.byType(Text);
    expect(text, findsNWidgets(3));
  });

  testWidgets('Should display text in portuguese when open app',
      (WidgetTester tester) async {
    await tester.pumpWidget(EasyLocalization(
        startLocale: const Locale.fromSubtags(languageCode: 'pt'),
        supportedLocales: [
          Locale.fromSubtags(languageCode: 'pt'),
          Locale.fromSubtags(languageCode: 'en'),
        ],
        path: 'assets/translations',
        fallbackLocale: Locale.fromSubtags(languageCode: 'en'),
        saveLocale: false,
        child: LocationApp()));
    await tester.pump();
    final textEnglish = find.text('Know your location');
    final textPortuguese = find.text('Saiba sua localização');
    expect(textPortuguese, findsOneWidget);
    expect(textEnglish, findsNothing);
  });
}
