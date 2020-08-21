import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:therapy_calendar/config/routes.dart';
import 'package:therapy_calendar/generated/l10n.dart';

import 'bloc/medication_entry_bloc.dart';

void main() {
  runApp(TherapyCalendar());
}

class TherapyCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routes = getRoutes();

    return BlocProvider(
      create: (_) => MedicationEntryBloc(),
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
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
