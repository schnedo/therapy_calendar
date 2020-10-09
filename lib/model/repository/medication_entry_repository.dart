import 'dart:convert';

import 'package:therapy_calendar/model/entry/medication_entry.dart';
import 'package:therapy_calendar/model/repository/repository.dart';
import 'package:therapy_calendar/model/serializers.dart';

class MedicationEntryRepository extends Repository {
  MedicationEntryRepository() : super(_fileName);

  static const _fileName = 'medication_entries.json';

  Future<List<MedicationEntry>> getAll() async {
    final jsonString = await read();

    try {
      return deserializeListOf<MedicationEntry>(jsonDecode(jsonString))
          .toList();
    } on FormatException {
      return [];
    }
  }

  Future<void> saveAll(List<MedicationEntry> medicationEntries) async {
    await write(jsonEncode(serialize(medicationEntries)));
  }
}
