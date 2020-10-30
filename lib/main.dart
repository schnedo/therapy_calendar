import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:therapy_calendar/bloc/color_bloc.dart';
import 'package:therapy_calendar/bloc/doctor_bloc.dart';
import 'package:therapy_calendar/bloc/medication_entry_bloc.dart';
import 'package:therapy_calendar/bloc/theme_bloc.dart';
import 'package:therapy_calendar/bloc/treatment_center_bloc.dart';
import 'package:therapy_calendar/bloc/user_bloc.dart';
import 'package:therapy_calendar/config/routes.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/model/repository/contact_repository.dart';
import 'package:therapy_calendar/model/repository/medication_entry_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TherapyCalendar());
}

class TherapyCalendar extends StatelessWidget {
  static const _userFileName = 'user.json';
  static const _doctorFileName = 'doctor.json';
  static const _treatmentCenterFileName = 'treatmentCenter.json';

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
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
            create: (_) => TreatmentCenterBloc(
                ContactRepository(_treatmentCenterFileName)),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => ThemeBloc(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => ColorBloc(),
            lazy: false,
          ),
        ],
        child: _MainApp(),
      );
}

class _MainApp extends StatefulWidget {
  @override
  __MainAppState createState() => __MainAppState();
}

class __MainAppState extends State<_MainApp> {
  @override
  Widget build(BuildContext context) {
    final routes = getRoutes();

    return BlocBuilder<ThemeBloc, ThemeMode>(
      builder: (context, themeMode) => BlocBuilder<ColorBloc, Color>(
        builder: (ctx, color) => MaterialApp(
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          initialRoute: routes.initialRoute,
          routes: routes.routes,
          title: 'Therapy Calendar',
          themeMode: themeMode,
          theme: ThemeData(
            primarySwatch: color,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          darkTheme: ThemeData(
            primarySwatch: color,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            brightness: Brightness.dark,
          ),
        ),
      ),
    );
  }
}
