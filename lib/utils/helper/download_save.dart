import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'fonctions.dart';


class FileStorage {
  static Future<String> getExternalDocumentPath() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    Directory _directory = Directory("dir");
    if (Platform.isAndroid) {
      _directory = await getApplicationDocumentsDirectory();
    } else {
      _directory = await getApplicationDocumentsDirectory();
    }

    final exPath = _directory.path;
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  static Future<String> get _localPath async {
    final String directory = await getExternalDocumentPath();
    return directory;
  }

  static Future<File> downloadAndSaveImage(String url) async {
    var response = await http.get(Uri.parse(url));
    Uint8List bytes = response.bodyBytes;

    // Generate a timestamp for the filename

    String fileName = basename(url);
    String filePath = join(await _localPath,fileName);
    File file = File(filePath);

    try {
      if (await file.exists()) {
        await file.delete();
      }

      await file.writeAsBytes(bytes, flush: true);
      FuzHelperFunctions.showToastNoContext("Image enregistré");
      return file; // Move the return statement inside the try block
    } catch (e) {
      throw e; // Rethrow the exception to handle it elsewhere if needed
    }
  }

}