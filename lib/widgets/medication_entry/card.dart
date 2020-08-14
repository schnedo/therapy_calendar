import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:therapy_calendar/model/medication_entry.dart';
import 'package:therapy_calendar/widgets/medication/card.dart';

class MedicationEntryCard extends StatelessWidget {
  const MedicationEntryCard({@required this.entry, Key key}) : super(key: key);

  final MedicationEntry entry;

  String get date => DateFormat.E().add_d().format(entry.date);

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                leading: Text(date),
                title: Column(
                  children: entry.medications
                      .map((med) => MedicationCard(medication: med))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<MedicationEntry>('entry', entry))
      ..add(StringProperty('date', date));
  }
}
