import 'dart:developer';
import 'dart:typed_data';

import 'package:simple_file_saver_platform_interface/simple_file_saver_platform_interface.dart';
import 'messages.g.dart' as messages;

class SimpleFileSaverAndroid extends SimpleFileSaverPlatform {
  final _api = messages.SimpleFileSaverApi();

  static void registerWith() {
    SimpleFileSaverPlatform.instance = SimpleFileSaverAndroid();
  }

  @override
  Future<bool?> saveFile({
    required Uint8List dataBytes,
    required String fileName,
    String? mimeType,
  }) async {
    try {
      return _api.saveFile(
        dataBytes: dataBytes,
        fileName: fileName,
        mimeType: mimeType,
      );
    } catch (e) {
      log('Exception: $e');
      return false;
    }
  }

  @override
  Future<bool?> saveFileAs({
    required Uint8List dataBytes,
    required String fileName,
    String? mimeType,
  }) async {
    try {
      return _api.saveFileAs(
        dataBytes: dataBytes,
        fileName: fileName,
        mimeType: mimeType,
      );
    } catch (e) {
      log('Exception: $e');
      return false;
    }
  }
}
