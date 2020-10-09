import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_mass.g.dart';

abstract class BodyMass implements Built<BodyMass, BodyMassBuilder> {
  factory BodyMass([void Function(BodyMassBuilder) updates]) = _$BodyMass;
  BodyMass._();

  static const unit = 'kg';

  int get amount;

  @override
  String toString() => '$amount $unit';

  static Serializer<BodyMass> get serializer => _$bodyMassSerializer;
}
