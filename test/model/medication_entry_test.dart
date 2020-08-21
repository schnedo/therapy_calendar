import 'package:built_collection/built_collection.dart';
import 'package:therapy_calendar/model/batch_number.dart';
import 'package:therapy_calendar/model/dose.dart';
import 'package:therapy_calendar/model/medicament.dart';
import 'package:therapy_calendar/model/medication.dart';
import 'package:therapy_calendar/model/medication_entry.dart';

MedicationEntry someEntry() => MedicationEntry((medication) => medication
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
