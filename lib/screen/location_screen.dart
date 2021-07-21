import 'package:flutter/material.dart';
import 'package:location_brazil/model/city.dart';
import 'package:location_brazil/bloc/bloc_provider.dart';
import 'package:location_brazil/bloc/location_bloc.dart';
import 'package:location_brazil/bloc/location_state.dart';
import 'package:easy_localization/easy_localization.dart';


class LocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LocationBloc bloc = BlocProvider.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('title'),
        ),
        leading: Image.asset('assets/icon/br.png'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              stream: bloc.stream,
              builder: (context, snapshot) {
                if (bloc.state is InitialState) {
                  return Text('');
                } else if (bloc.state is ErrorState) {
                  final String textError =
                      (bloc.state as ErrorState).error?.toString() ??
                          'Unknow error';
                  return Text(
                    textError,
                    textAlign: TextAlign.center,
                  );
                } else if (bloc.state is ProcessingState) {
                  return CircularProgressIndicator();
                } else {
                  final City city = (bloc.state as SuccessState).city;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      city.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 32),
                    ),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  bloc.add(LocationEvent.process);
                },
                child: Text(
                  tr('button_text'),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
