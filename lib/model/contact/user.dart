import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:therapy_calendar/model/contact/body_mass.dart';
import 'package:therapy_calendar/model/contact/contact.dart';

part 'user.g.dart';

class NonUtcDateException implements Exception {}

abstract class User implements Contact, Built<User, UserBuilder> {
  factory User([void Function(UserBuilder) updates]) = _$User;

  User._() {
    if (!birthdate.isUtc) {
      throw NonUtcDateException();
    }
  }

  DateTime get birthdate;
  BodyMass get bodyMass;
  String get diagnosis;

  static Serializer<User> get serializer => _$userSerializer;
}

abstract class UserBuilder implements Builder<User, UserBuilder> {
  factory UserBuilder() = _$UserBuilder;
  UserBuilder._();

  DateTime _birthdate;
  DateTime get birthdate => _birthdate;
  set birthdate(DateTime dateTime) => _birthdate = dateTime.toUtc();

  BodyMassBuilder bodyMass;
  String diagnosis;
  String fullName;
  String address;
  String phoneNumber;
}
