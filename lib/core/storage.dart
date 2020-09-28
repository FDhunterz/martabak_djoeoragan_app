import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class PenyimpananKu {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _berkasLokal(String namaFile) async {
    final path = await _localPath;
    print(path);
    return File('$path/$namaFile');
  }

  /// untuk membaca file.
  /// contoh: example.txt atau folder/example.txt
  Future<String> bacaBerkas(String namaFile) async {
    try {
      final file = await _berkasLokal(namaFile);

      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return ''
      return '';
    }
  }

  /// untuk menulis file.
  /// @content = tulis isi file.
  /// @namaFile = nama berkas contoh: example.txt atau folder/example.txt
  Future<File> tulisBerkas(String content, String namaFile) async {
    final file = await _berkasLokal(namaFile);

    return file.writeAsString('$content');
  }

  Future<void> hapusBerkas(String namaFile) async {
    final file = await _berkasLokal(namaFile);

    try {
      if (await file.exists()) {
        file.delete();
      } else {
        print('file tidak ada');
      }
      print('success');
    } catch (e) {
      print(e);
    }
  }
}
