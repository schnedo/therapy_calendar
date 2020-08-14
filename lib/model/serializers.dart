import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:therapy_calendar/model/batch_number.dart';
import 'package:therapy_calendar/model/dose.dart';
import 'package:therapy_calendar/model/medicament.dart';
import 'package:therapy_calendar/model/medication.dart';
import 'package:therapy_calendar/model/medication_entry.dart';

part 'serializers.g.dart';

@SerializersFor([
  Medication,
  MedicationEntry,
  Medicament,
  Dose,
  BatchNumber,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

// We work with dynamic here, therefore no type annotation necessary
// ignore: type_annotate_public_apis
T deserialize<T>(value) =>
    serializers.deserializeWith(serializers.serializerForType(T), value);

// We work with dynamic here, therefore no type annotation necessary
// ignore: type_annotate_public_apis
BuiltList<T> deserializeListOf<T>(value) => BuiltList.from(
    value.map((val) => deserialize<T>(val)).toList(growable: false));
