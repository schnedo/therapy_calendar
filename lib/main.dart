import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:therapy_calendar/bloc/doctor_bloc.dart';
import 'package:therapy_calendar/bloc/treatment_center_bloc.dart';
import 'package:therapy_calendar/bloc/user_bloc.dart';
import 'package:therapy_calendar/config/routes.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/model/repository/contact_repository.dart';
import 'package:therapy_calendar/model/repository/medication_entry_repository.dart';

import 'bloc/medication_entry_bloc.dart';

void main() {
  runApp(TherapyCalendar());
}

class TherapyCalendar extends StatelessWidget {
  static const _userFileName = 'user.json';
  static const _doctorFileName = 'doctor.json';
  static const _treatmentCenterFileName = 'treatmentCenter.json';

  @override
  Widget build(BuildContext context) {
    final routes = getRoutes();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MedicationEntryBloc(MedicationEntryRepository()),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => UserBloc(ContactRepository(_userFileName)),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => DoctorBloc(ContactRepository(_doctorFileName)),
          lazy: false,
        ),
        BlocProvider(
          create: (_) =>
              TreatmentCenterBloc(ContactRepository(_treatmentCenterFileName)),
          lazy: false,
        ),
      ],
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
