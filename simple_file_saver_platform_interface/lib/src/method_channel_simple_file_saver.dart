import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/services.dart';

import '../simple_file_saver_platform_interface.dart';

/// An implementation of [SimpleFileSaverPlatform] that uses method channels.
class MethodChannelSimpleFileSaver extends SimpleFileSaverPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  MethodChannel methodChannel = const MethodChannel('laemont/simple_file_saver');

  @override
  Future<bool> saveFile({
    required Uint8List dataBytes,
    required String fileName,
    String? mimeType,
  }) {
    return methodChannel.invokeMethod<bool>(
      'saveFile',
      <String, dynamic>{
        'dataBytes': dataBytes,
        'fileName': fileName,
        'mimeType': mimeType,
      },
    ).then((value) => value ?? false);
  }

  @override
  Future<bool> saveFileAs({
    required Uint8List dataBytes,
    required String fileName,
    String? mimeType,
  }) {
    return methodChannel.invokeMethod<bool>(
      'saveFileAs',
      <String, dynamic>{
        'dataBytes': dataBytes,
        'fileName': fileName,
        'mimeType': mimeType,
      },
    ).then((value) => value ?? false);
  }
}
