import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:therapy_calendar/model/medication_entry.dart';

import 'bloc/medication_entry_bloc.dart';
import 'model/batch.dart';
import 'model/dose.dart';

void main() {
  runApp(MyApp());
}

class DayView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Therapy Calendar')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context
                .bloc<MedicationEntryBloc>()
                .add(MedicationEntry((medication) => medication
                  ..batch = Batch((batch) => batch.number = 2).toBuilder()
                  ..date = DateTime.now()
                  ..dose = Dose((dose) => dose
                    ..count = 2
                    ..singleDose = 20).toBuilder()));
          },
          child: const Icon(Icons.add),
        ),
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
                child: BlocBuilder<MedicationEntryBloc, List<MedicationEntry>>(
              buildWhen: (_, __) => true,
              builder: (context, medicationEntries) => ListView.builder(
                itemBuilder: (ctx, index) {
                  final item = medicationEntries[index];
                  final date = DateFormat.E().add_d().format(item.date);

                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('$date'),
                        Text('${item.batch.number}'),
                        Text('${item.dose.count} x'
                            '${item.dose.singleDose} ml'),
                      ],
                    ),
                  );
                },
                itemCount: medicationEntries.length,
              ),
            )),
          ],
        ),
      );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'de_DE';
    initializeDateFormatting();

    return BlocProvider(
      create: (_) => MedicationEntryBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: DayView(),
      ),
    );
  }
}
