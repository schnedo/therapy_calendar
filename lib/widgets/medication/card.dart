import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:therapy_calendar/model/entry/medication.dart';

class MedicationCard extends StatelessWidget {
  const MedicationCard({@required this.medication, Key key}) : super(key: key);

  final Medication medication;

  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          title: Text(medication.medicament.name),
          subtitle: Text(medication.medicament.batchNumber.toString()),
          trailing: Text(medication.dose.toString()),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Medication>('medication', medication));
  }
}
