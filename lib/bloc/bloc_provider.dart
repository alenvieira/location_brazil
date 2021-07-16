import 'package:flutter/material.dart';
import 'package:location_brazil/bloc/location_bloc.dart';

class BlocProvider extends InheritedWidget {
  final LocationBloc bloc;

  BlocProvider({required this.bloc, required Widget child})
      : super(child: child);

  static LocationBloc get(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<BlocProvider>();
    if (provider != null) {
      return provider.bloc;
    } else {
      throw Exception('Not found bloc');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return (oldWidget as BlocProvider).bloc.state != bloc.state;
  }
}
