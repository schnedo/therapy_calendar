import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:therapy_calendar/model/dose.dart';
import 'package:therapy_calendar/model/medicament.dart';

part 'medication.g.dart';

abstract class Medication implements Built<Medication, MedicationBuilder> {
  factory Medication([void Function(MedicationBuilder) updates]) = _$Medication;

  Medication._();

  Dose get dose;
  Medicament get medicament;

  static Serializer<Medication> get serializer => _$medicationSerializer;
}
