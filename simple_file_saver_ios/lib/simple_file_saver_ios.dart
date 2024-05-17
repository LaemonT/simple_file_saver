import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:simple_file_saver_platform_interface/simple_file_saver_platform_interface.dart';
import 'messages.g.dart' as messages;

class SimpleFileSaverIos extends SimpleFileSaverPlatform {
  final _api = messages.SimpleFileSaverApi();

  static void registerWith() {
    SimpleFileSaverPlatform.instance = SimpleFileSaverIos();
  }

  @override
  Future<String?> saveFile({
    required FileSaveInfo fileInfo,
    bool saveAs = false,
  }) async {
    final Uint8List dataBytes;
    switch (fileInfo) {
      case FileBytesInfo fileInfo:
        dataBytes = fileInfo.bytes;
        break;
      case FileUrlInfo fileInfo:
        // Download in bytes
        dataBytes = await _getBytes(fileInfo.uri);
        break;
      default:
        throw 'Undefined type.';
    }

    if (saveAs) {
      // Save file as using the platform-specific code
      return _api.saveFileAs(
        dataBytes: dataBytes,
        filenameWithExtension: fileInfo.filenameWithExtension,
      );
    }

    // Save file to the default directory, and return the directory path
    return _saveFile(dataBytes, fileInfo);
  }

  Future<String?> _saveFile(
    Uint8List dataBytes,
    FileSaveInfo fileInfo,
  ) async {
    // Get the document directory path
    final directory = await _api.getDocumentDirectory();

    // Check file existence and avoid duplication
    var file = File('$directory/${fileInfo.filenameWithExtension}');
    var count = 1;
    while (await file.exists()) {
      file = File('$directory/${fileInfo.basename} ($count)${fileInfo.extension}');
      count++;
    }

    // Write file as bytes to the directory
    await file.writeAsBytes(dataBytes);

    // Return the directory path
    return file.path;
  }

  Future<Uint8List> _getBytes(Uri uri) async {
    final request = await HttpClient().getUrl(uri);
    final response = await request.close();
    return await consolidateHttpClientResponseBytes(response);
  }
}
