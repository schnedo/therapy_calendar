import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:therapy_calendar/model/batch_number.dart';
import 'package:therapy_calendar/model/dose.dart';
import 'package:therapy_calendar/model/medicament.dart';
import 'package:therapy_calendar/model/medication.dart';
import 'package:therapy_calendar/model/medication_entry.dart';
import 'package:therapy_calendar/widgets/day_view.dart';
import 'package:therapy_calendar/widgets/medication_entry/add.dart';
import 'package:therapy_calendar/widgets/medication_entry/card.dart';

class Routes {
  Routes({this.initialRoute, this.routes});

  final String initialRoute;
  final Map<String, WidgetBuilder> routes;
}

Routes getRoutes() => Routes(initialRoute: '/debug', routes: {
      DayView.routeName: (_) => DayView(),
      AddMedicationEntry.routeName: (_) => AddMedicationEntry(),
      '/debug': (_) => Scaffold(
            appBar: AppBar(),
            body: MedicationEntryCard(
              entry: MedicationEntry((medication) => medication
                ..medications = ListBuilder<Medication>([
                  Medication(
                    (b) => b
                      ..medicament = (MedicamentBuilder()
                        ..batchNumber =
                            (BatchNumberBuilder()..number = 12345678)
                        ..name = 'Medikament')
                      ..dose = (DoseBuilder()..amount = 20),
                  ),
                  Medication(
                    (b) => b
                      ..medicament = (MedicamentBuilder()
                        ..batchNumber =
                            (BatchNumberBuilder()..number = 12345678)
                        ..name = 'Medikament')
                      ..dose = (DoseBuilder()..amount = 20),
                  )
                ])
                ..date = DateTime.now()
                ..duration = const Duration(hours: 2)
                ..comments = ''),
            ),
          ),
    });
