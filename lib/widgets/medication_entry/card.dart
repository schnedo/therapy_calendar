import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:therapy_calendar/model/entry/medication_entry.dart';
import 'package:therapy_calendar/widgets/medication/card.dart';

extension _Formatting on Duration {
  String get _hours =>
      (inMinutes ~/ Duration.minutesPerHour).toString().padLeft(2, '0');
  String get _minutes =>
      (inMinutes % Duration.minutesPerHour).toString().padLeft(2, '0');

  String formatted() => '$_hours:$_minutes';
}

class MedicationEntryCard extends StatelessWidget {
  const MedicationEntryCard({required this.entry, Key? key})
      : super(key: key);

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
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: Text(entry.comments),
                ),
                trailing: Column(
                  children: [
                    Text(entry.duration.formatted()),
                    Container(
                      width: 40,
                      child: const Divider(),
                    ),
                    Text(entry.bodyMass.toString()),
                  ],
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
