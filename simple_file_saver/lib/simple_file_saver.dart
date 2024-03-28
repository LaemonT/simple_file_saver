import 'dart:typed_data';

import 'package:simple_file_saver_platform_interface/platform_interface.dart';

SimpleFileSaverPlatform get _platform => SimpleFileSaverPlatform.instance;

class SimpleFileSaver {
  SimpleFileSaver._();

  /// Save the file to the default location.
  ///
  /// Android defaults to the downloads directory.
  ///
  /// iOS defaults to the documents directory, requires setting the 'Supports Document Browser' key
  /// to YES in the info.plist to reveal the directory to the other apps.
  static Future<bool> saveFile({
    required Uint8List dataBytes,
    required String fileName,
    String? mimeType,
  }) async {
    final result = await _platform.saveFile(
      dataBytes: dataBytes,
      fileName: fileName,
      mimeType: mimeType,
    );
    return result ?? false;
  }

  /// Prompt to the users and save the file to the specified location.
  static Future<bool> saveFileAs({
    required Uint8List dataBytes,
    required String fileName,
    String? mimeType,
  }) async {
    final result = await _platform.saveFileAs(
      dataBytes: dataBytes,
      fileName: fileName,
      mimeType: mimeType,
    );
    return result ?? false;
  }
}
