import 'package:flutter/services.dart';

import '../simple_file_saver_platform_interface.dart';

const _channel = MethodChannel('laemont/simple_file_saver');

/// The default interface implementation acting as a placeholder for
/// the native implementation to be set.
///
/// This implementation is not used by any of the implementations in this
/// repository, and exists only for backward compatibility with any
/// clients that were relying on internal details of the method channel
/// in the pre-federated plugin.
class DefaultSimpleFileSaverPlatform extends SimpleFileSaverPlatform {
  @override
  Future<String?> saveFile({
    required FileSaveInfo fileInfo,
    bool saveAs = false,
  }) {
    return _channel.invokeMethod(
      'saveFile',
      <String, dynamic>{
        'basename': fileInfo.basename,
        'extension': fileInfo.extension,
        'mimeType': fileInfo.mimeType,
        'saveAs': saveAs,
      },
    );
  }
}
