import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:therapy_calendar/model/medication_entry.dart';
import 'package:therapy_calendar/model/serializers.dart';

class MedicationEntryRepository {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/medication_entries.json').create();
  }

  static Future<File> _write(String jsonString) async {
    final file = await _localFile;
    return file.writeAsString(jsonString);
  }

  static Future<String> _read() async {
    final file = await _localFile;
    return file.readAsString();
  }

  Future<List<MedicationEntry>> getAll() async {
    final jsonString = await _read();
    try {
      final decoded = jsonDecode(jsonString);
      final list = deserializeListOf<MedicationEntry>(decoded);
      return Future(list.toList);
    } on FormatException {
      return [];
    }
  }

  Future<void> saveAll(List<MedicationEntry> medicationEntries) async {
    final serialized = serialize(medicationEntries);
    final jsonString = jsonEncode(serialized);
    await _write(jsonString);
  }
}
