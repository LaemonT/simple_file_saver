import 'dart:typed_data';

import 'package:simple_file_saver_platform_interface/platform_interface.dart';
import 'messages.g.dart' as messages;

class SimpleFileSaverIos extends SimpleFileSaverPlatform {
  final _api = messages.SimpleFileSaverApi();

  static void registerWith() {
    SimpleFileSaverPlatform.instance = SimpleFileSaverIos();
  }

  @override
  Future<bool?> saveFile({
    required Uint8List dataBytes,
    required String fileName,
    String? mimeType,
  }) {
    return _api.saveFile(
      dataBytes: dataBytes,
      fileName: fileName,
    );
  }

  @override
  Future<bool?> saveFileAs({
    required Uint8List dataBytes,
    required String fileName,
    String? mimeType,
  }) {
    return _api.saveFileAs(
      dataBytes: dataBytes,
      fileName: fileName,
    );
  }
}
