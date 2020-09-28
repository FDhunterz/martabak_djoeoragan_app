import 'dart:io';

import 'package:path/path.dart' as p;

Directory appDocsDir;

File fileFromDocsDir(String filename) {
  String pathName = p.join(appDocsDir.path, filename);
  return File(pathName);
}
