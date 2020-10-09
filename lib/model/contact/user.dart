import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:therapy_calendar/model/contact/contact.dart';

part 'user.g.dart';

abstract class User implements Contact, Built<User, UserBuilder> {
  factory User([void Function(UserBuilder) updates]) = _$User;

  User._();

  DateTime get birthdate;
  double get bodyMass;
  String get diagnosis;

  static Serializer<User> get serializer => _$userSerializer;
}
