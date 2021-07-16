// @dart=2.11
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location_brazil/bloc/bloc_provider.dart';
import 'package:location_brazil/bloc/location_bloc.dart';
import 'package:location_brazil/screen/location_screen.dart';

import '../mock/mock.dart';

void main() {
  final dao = MockLocationDao();
  final location = MockLocation();
  final bloc = LocationBloc(dao, location);

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
}
