import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:therapy_calendar/model/contact/body_mass.dart';
import 'package:therapy_calendar/model/contact/doctor.dart';
import 'package:therapy_calendar/model/contact/treatment_center.dart';
import 'package:therapy_calendar/model/contact/user.dart';
import 'package:therapy_calendar/model/entry/batch_number.dart';
import 'package:therapy_calendar/model/entry/dose.dart';
import 'package:therapy_calendar/model/entry/medicament.dart';
import 'package:therapy_calendar/model/entry/medication.dart';
import 'package:therapy_calendar/model/entry/medication_entry.dart';

import 'entry/photo.dart';

part 'serializers.g.dart';

const _medicationEntryBuiltListType =
    FullType(BuiltList, [FullType(MedicationEntry)]);

@SerializersFor([
  Medication,
  MedicationEntry,
  Medicament,
  Dose,
  BatchNumber,
  Doctor,
  TreatmentCenter,
  User,
  BodyMass,
  Photo,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
          _medicationEntryBuiltListType, () => ListBuilder<MedicationEntry>())
      ..addPlugin(StandardJsonPlugin()))
    .build();

dynamic serialize(List<MedicationEntry> medicationEntries) =>
    serializers.serialize(medicationEntries.toBuiltList(),
        specifiedType: _medicationEntryBuiltListType);

// We work with dynamic here, therefore no type annotation necessary
// ignore: type_annotate_public_apis
T deserialize<T>(value) =>
    serializers.deserializeWith(serializers.serializerForType(T), value);

// We work with dynamic here, therefore no type annotation necessary
// ignore: type_annotate_public_apis
BuiltList<T> deserializeListOf<T>(value) => BuiltList.from(
    value.map((val) => deserialize<T>(val)).toList(growable: false));
