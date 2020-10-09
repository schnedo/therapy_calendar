import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:therapy_calendar/model/entry/medication.dart';

part 'medication_entry.g.dart';

class NonUtcDateException implements Exception {}

abstract class MedicationEntry
    implements Built<MedicationEntry, MedicationEntryBuilder> {
  factory MedicationEntry([void Function(MedicationEntryBuilder) updates]) =
      _$MedicationEntry;

  MedicationEntry._() {
    if (!date.isUtc) {
      throw NonUtcDateException();
    }
  }

  DateTime get date;

  BuiltList<Medication> get medications;

  Duration get duration;

  String get comments;

  static Serializer<MedicationEntry> get serializer =>
      _$medicationEntrySerializer;
}

abstract class MedicationEntryBuilder
    implements Builder<MedicationEntry, MedicationEntryBuilder> {
  factory MedicationEntryBuilder() = _$MedicationEntryBuilder;
  MedicationEntryBuilder._();

  DateTime _date;
  DateTime get date => _date;
  set date(DateTime dateTime) => _date = dateTime.toUtc();

  ListBuilder<Medication> medications;

  Duration duration;

  String comments;
}
