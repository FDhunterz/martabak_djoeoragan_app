import 'dart:io';
import 'dart:async';
// import 'package:martabakdjoeragan_app/pages/ImageToFile/ImageToFile.dart';
// ignore: unused_import
import 'package:path_provider/path_provider.dart';

class PenyimpananKu {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _berkasLokal(String namaFile) async {
    /// # var appDocsDir dari main.dart
    // final path = appDocsDir.path;
    final path = await _localPath;
    // print(path);
    File file = File('$path/$namaFile');
    return file;
  }

  /// untuk membaca file.
  /// contoh: example.txt atau folder/example.txt
  Future<String> bacaBerkas(String namaFile) async {
    final File file = await _berkasLokal(namaFile);

    bool kondisi = await file.exists();

    if (kondisi) {
      String contents = await file.readAsString();

      return contents;
    } else {
      tulisBerkas('', namaFile);
      final File fileX = await _berkasLokal(namaFile);
      String contentXs = await fileX.readAsString();

      return contentXs;
    }
    // return empty string if not exist
    // return '';
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
