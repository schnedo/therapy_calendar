import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:therapy_calendar/config/routes.dart';

import 'bloc/medication_entry_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'de_DE';
    initializeDateFormatting();
    final routes = getRoutes();

    return BlocProvider(
      create: (_) => MedicationEntryBloc(),
      child: MaterialApp(
        initialRoute: routes.initialRoute,
        routes: routes.routes,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
