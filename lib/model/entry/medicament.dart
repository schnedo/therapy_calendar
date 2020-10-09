import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:therapy_calendar/model/entry/batch_number.dart';

part 'medicament.g.dart';

abstract class Medicament implements Built<Medicament, MedicamentBuilder> {
  factory Medicament([void Function(MedicamentBuilder) updates]) = _$Medicament;
  Medicament._();

  String get name;

  BatchNumber get batchNumber;

  static Serializer<Medicament> get serializer => _$medicamentSerializer;
}
