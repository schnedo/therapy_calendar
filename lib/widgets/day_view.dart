import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:therapy_calendar/bloc/medication_entry_bloc.dart';
import 'package:therapy_calendar/model/medication_entry.dart';
import 'package:therapy_calendar/widgets/medication_entry/add.dart';

class DayView extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Therapy Calendar')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddMedicationEntry.routeName);
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
