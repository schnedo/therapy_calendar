import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:therapy_calendar/model/contact/contact.dart';

part 'treatment_center.g.dart';

abstract class TreatmentCenter
    implements Contact, Built<TreatmentCenter, TreatmentCenterBuilder> {
  factory TreatmentCenter([void Function(TreatmentCenterBuilder) updates]) =
      _$TreatmentCenter;
  TreatmentCenter._();

  static Serializer<TreatmentCenter> get serializer =>
      _$treatmentCenterSerializer;
}
