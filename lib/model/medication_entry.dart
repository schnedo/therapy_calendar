import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:therapy_calendar/model/batch.dart';
import 'package:therapy_calendar/model/dose.dart';

part 'medication_entry.g.dart';

abstract class MedicationEntry
    implements Built<MedicationEntry, MedicationEntryBuilder> {
  factory MedicationEntry([void Function(MedicationEntryBuilder) updates]) =
      _$MedicationEntry;

  MedicationEntry._();

  DateTime get date;

  Batch get batch;

  Dose get dose;

  Duration get duration;

  String get comments;

  static Serializer<MedicationEntry> get serializer =>
      _$medicationEntrySerializer;
}
