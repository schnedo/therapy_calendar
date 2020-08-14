import 'package:flutter/cupertino.dart';
import 'package:therapy_calendar/views/day_view.dart';
import 'package:therapy_calendar/views/medication_entry/add.dart';

class Routes {
  Routes({this.initialRoute, this.routes});

  final String initialRoute;
  final Map<String, WidgetBuilder> routes;
}

Routes getRoutes() => Routes(initialRoute: '/', routes: {
      DayView.routeName: (_) => DayView(),
      AddMedicationEntry.routeName: (_) => AddMedicationEntry()
    });