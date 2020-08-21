import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:therapy_calendar/widgets/day_view.dart';
import 'package:therapy_calendar/widgets/medication_entry/add.dart';

class Routes {
  Routes({this.initialRoute, this.routes});

  final String initialRoute;
  final Map<String, WidgetBuilder> routes;
}

Routes getRoutes() => Routes(initialRoute: DayView.routeName, routes: {
      DayView.routeName: (_) => DayView(),
      AddMedicationEntry.routeName: (_) => AddMedicationEntry(),
    });
