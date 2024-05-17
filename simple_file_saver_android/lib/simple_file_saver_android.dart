import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:simple_file_saver_platform_interface/simple_file_saver_platform_interface.dart';
import 'messages.g.dart' as messages;

class SimpleFileSaverAndroid extends SimpleFileSaverPlatform {
  final _api = messages.SimpleFileSaverApi();

  static void registerWith() {
    SimpleFileSaverPlatform.instance = SimpleFileSaverAndroid();
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
        mimeType: fileInfo.mimeType,
      );
    }

    // Save file to the default directory, and return the directory path
    return _api.saveToDownloads(
      dataBytes: dataBytes,
      filenameWithExtension: fileInfo.filenameWithExtension,
    );
  }

  Future<Uint8List> _getBytes(Uri uri) async {
    final request = await HttpClient().getUrl(uri);
    final response = await request.close();
    return await consolidateHttpClientResponseBytes(response);
  }
}
