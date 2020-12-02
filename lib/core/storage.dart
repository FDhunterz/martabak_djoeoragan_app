import 'dart:io';
import 'dart:async';
import 'package:martabakdjoeragan_app/pages/ImageToFile/ImageToFile.dart';
// ignore: unused_import
import 'package:path_provider/path_provider.dart';

class PenyimpananKu {
  // Future<String> get _localPath async {
  //   final directory = await getApplicationDocumentsDirectory();

  //   return directory.path;
  // }

  File _berkasLokal(String namaFile) {
    /// # var appDocsDir dari main.dart
    final path = appDocsDir.path;
    print(path);
    File file = File('$path/$namaFile');
    return file;
  }

  /// untuk membaca file.
  /// contoh: example.txt atau folder/example.txt
  Future<String> bacaBerkas(String namaFile) async {
    final File file = _berkasLokal(namaFile);

    bool kondisi = await file.exists();

    if (kondisi) {
      String contents = await file.readAsString();

      return contents;
    }
    // return empty string if not exist
    return '';
  }

  /// untuk menulis file.
  /// @content = tulis isi file.
  /// @namaFile = nama berkas contoh: example.txt atau folder/example.txt
  Future<File> tulisBerkas(String content, String namaFile) async {
    final file = _berkasLokal(namaFile);

    return file.writeAsString('$content');
  }

  Future<void> hapusBerkas(String namaFile) async {
    final file = _berkasLokal(namaFile);

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
