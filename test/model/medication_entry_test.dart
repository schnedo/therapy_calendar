import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:therapy_calendar/model/medication.dart';
import 'package:therapy_calendar/model/medication_entry.dart';

MedicationEntry someEntry() => MedicationEntry((medication) => medication
  ..medications = ListBuilder<Medication>([
    Medication(
      (b) => b
        ..medicament.name = 'Medikament'
        ..medicament.batchNumber.number = 12345678
        ..dose.amount = 20,
    ),
    Medication(
      (b) => b
        ..medicament.name = 'Medikament'
        ..medicament.batchNumber.number = 12345678
        ..dose.amount = 20,
    )
  ])
  ..date = DateTime.now()
  ..duration = const Duration(hours: 2)
  ..comments = 'Einnahme 400 mg Paracetamol');

void main() {
  group('MedicationEntry', () {
    test('should be true', () async {
      expect(true, isTrue);
    });
  });
}
