import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:therapy_calendar/model/batch.dart';
import 'package:therapy_calendar/model/dose.dart';
import 'package:therapy_calendar/model/medication_entry.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'de_DE';
    initializeDateFormatting();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DayView(),
    );
  }
}

class DataClass {
  DataClass(this.date, this.batch, this.dose);

  final DateTime date;
  final String batch;
  final String dose;
}

class DayView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final def = MedicationEntry((medication) => medication
      ..batch = Batch((batch) => batch.number = 2).toBuilder()
      ..date = DateTime.now()
      ..dose = Dose((dose) => dose
        ..count = 2
        ..singleDose = 20).toBuilder());
    final defaultList = <MedicationEntry>[];
    final rng = Random();
    for (var i = 0; i < 100; i++) {
      defaultList.add(def.rebuild(
          (medication) => medication.batch.number = rng.nextInt(210243)));
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Therapy Calendar')),
      body: Column(
        children: [
          ListTile(
              title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('DATUM'),
              const Text('BATCH'),
              const Text('DOSIS'),
            ],
          )),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                final item = defaultList[index];
                final date = DateFormat.E().add_d().format(item.date);

                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('$date'),
                      Text('${item.batch.number}'),
                      Text('${item.dose.count} x ${item.dose.singleDose} ml'),
                    ],
                  ),
                );
              },
              itemCount: defaultList.length,
            ),
          )
        ],
      ),
    );
  }
}
