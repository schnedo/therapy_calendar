import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapy_calendar/bloc/medication_entry_bloc.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/model/medication_entry.dart';
import 'package:therapy_calendar/views/add_medication_entry.dart';
import 'package:therapy_calendar/widgets/medication_entry/card.dart';

class DayView extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(S.of(context).dayViewTitle)),
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
