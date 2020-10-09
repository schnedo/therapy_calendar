import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:therapy_calendar/views/add_medication_entry.dart';
import 'package:therapy_calendar/views/day_view.dart';
import 'package:therapy_calendar/views/doctor_profile.dart';
import 'package:therapy_calendar/views/treatment_center_profile.dart';
import 'package:therapy_calendar/views/user_profile.dart';

class Routes {
  Routes({@required this.initialRoute, @required this.routes});

  final String initialRoute;
  final Map<String, WidgetBuilder> routes;
}

Routes getRoutes() => Routes(initialRoute: DayView.routeName, routes: {
      DayView.routeName: (_) => DayView(),
      AddMedicationEntry.routeName: (_) => AddMedicationEntry(),
      UserProfile.routeName: (_) => UserProfile(),
      DoctorProfile.routeName: (_) => DoctorProfile(),
      TreatmentCenterProfile.routeName: (_) => TreatmentCenterProfile(),
    });
