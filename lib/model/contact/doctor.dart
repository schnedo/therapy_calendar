import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:therapy_calendar/model/contact/contact.dart';

part 'doctor.g.dart';

abstract class Doctor implements Contact, Built<Doctor, DoctorBuilder> {
  factory Doctor([void Function(DoctorBuilder) updates]) = _$Doctor;

  Doctor._();

  static Serializer<Doctor> get serializer => _$doctorSerializer;
}
