import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Repository {
  Repository(this._fileName);

  final String _fileName;

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_fileName').create();
  }

  Future<File> write(String jsonString) async {
    final file = await _localFile;
    return file.writeAsString(jsonString);
  }

  Future<String> read() async {
    final file = await _localFile;
    return file.readAsString();
  }
}
