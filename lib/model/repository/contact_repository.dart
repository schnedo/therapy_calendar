import 'dart:convert';

import 'package:therapy_calendar/model/contact/contact.dart';
import 'package:therapy_calendar/model/repository/repository.dart';
import 'package:therapy_calendar/model/serializers.dart';

class ContactRepository<T extends Contact> extends Repository {
  ContactRepository(String fileName) : super(fileName);

  Future<T> get() async {
    final jsonString = await read();

    try {
      return deserialize<T>(jsonDecode(jsonString));
    } on FormatException {
      return null;
    }
  }

  Future<void> save(T contact) async {
    await write(jsonEncode(serializers.serialize(contact)));
  }
}
