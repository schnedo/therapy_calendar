import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapy_calendar/bloc/medication_entry_bloc.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/model/batch_number.dart';
import 'package:therapy_calendar/model/dose.dart';
import 'package:therapy_calendar/model/medicament.dart';
import 'package:therapy_calendar/model/medication.dart';
import 'package:therapy_calendar/model/medication_entry.dart';
import 'package:therapy_calendar/widgets/medication_entry/card.dart';

MedicationEntry _someEntry() => MedicationEntry((medication) => medication
  ..medications = ListBuilder<Medication>([
    Medication(
      (b) => b
        ..medicament = (MedicamentBuilder()
          ..batchNumber = (BatchNumberBuilder()..number = 12345678)
          ..name = 'Medikament')
        ..dose = (DoseBuilder()..amount = 20),
    ),
    Medication(
      (b) => b
        ..medicament = (MedicamentBuilder()
          ..batchNumber = (BatchNumberBuilder()..number = 12345678)
          ..name = 'Medikament')
        ..dose = (DoseBuilder()..amount = 20),
    )
  ])
  ..date = DateTime.now()
  ..duration = const Duration(hours: 2)
  ..comments = 'Einnahme 400 mg Paracetamol');

class DayView extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(S.of(context).dayViewTitle)),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.bloc<MedicationEntryBloc>().add(_someEntry());
//            Navigator.pushNamed(context, AddMedicationEntry.routeName);
          },
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            ListTile(
                title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).dayViewDateHeader),
                Text(S.of(context).dayViewMedicationHeader),
                Text(S.of(context).dayViewDurationHeader),
              ],
            )),
            const Divider(),
            Expanded(
                child: BlocBuilder<MedicationEntryBloc, List<MedicationEntry>>(
              buildWhen: (_, __) => true,
              builder: (context, medicationEntries) => ListView.builder(
                itemBuilder: (ctx, index) =>
                    MedicationEntryCard(entry: medicationEntries[index]),
                itemCount: medicationEntries.length,
              ),
            )),
          ],
        ),
      );
}
