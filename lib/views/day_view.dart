import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapy_calendar/bloc/medication_entry_bloc.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/model/medication_entry.dart';
import 'package:therapy_calendar/views/add_medication_entry.dart';
import 'package:therapy_calendar/widgets/medication_entry/card.dart';

enum _Changes { delete }

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
                itemBuilder: (ctx, index) => GestureDetector(
                  onLongPressStart: (details) =>
                      longPressMenu(ctx, details, medicationEntries[index]),
                  child: MedicationEntryCard(entry: medicationEntries[index]),
                ),
                itemCount: medicationEntries.length,
              ),
            )),
          ],
        ),
      );

  Future<void> longPressMenu(BuildContext context,
      LongPressStartDetails details, MedicationEntry medicationEntry) async {
    final result = await showMenu<_Changes>(
      context: context,
      position: RelativeRect.fromLTRB(
          details.globalPosition.dx, details.globalPosition.dy, 0, 0),
      items: [
        PopupMenuItem(
          value: _Changes.delete,
          child: Text(S.of(context).dayViewDeleteLabel),
        ),
      ],
      elevation: 8,
    );

    switch (result) {
      case _Changes.delete:
        context.bloc<MedicationEntryBloc>().remove(medicationEntry);
        break;
    }
  }
}
