import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dose.g.dart';

abstract class Dose implements Built<Dose, DoseBuilder> {
  factory Dose([void Function(DoseBuilder) updates]) = _$Dose;

  Dose._();

  int get singleDose;

  int get count;

  static Serializer<Dose> get serializer => _$doseSerializer;
}
