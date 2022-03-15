import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appprueba/blocs/blocs.dart';

import 'package:appprueba/ui/screens/screens.dart';
import 'package:appprueba/services/services.dart';

void main() {
  runApp( 
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GpsBloc() ),
        BlocProvider(create: (context) => LocationBloc() ),
        BlocProvider(create: (context) => MapBloc(context: context)),
      ],
      child: const MapsApp(),
    )
  );
}

class MapsApp extends StatelessWidget {
  
  const MapsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MapsApp',
      home: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return state.isAllGranted
              ? const MapScreen()
              : const GpsAccessScreen();
        },
      )
    );
  }
}