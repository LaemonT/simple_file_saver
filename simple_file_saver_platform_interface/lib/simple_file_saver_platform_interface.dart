import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'src/method_channel_simple_file_saver.dart';

/// The interface that implementations of simple_file_saver must implement.
///
/// Platform implementations should extend this class rather than implement it as `SimpleFileSaver`
/// does not consider newly added methods to be breaking changes. Extending this class
/// (using `extends`) ensures that the subclass will get the default implementation, while
/// platform implementations that `implements` this interface will be broken by newly added
/// [SimpleFileSaverPlatform] methods.
abstract class SimpleFileSaverPlatform extends PlatformInterface {
  /// Constructs a SimpleFileSaverPlatform.
  SimpleFileSaverPlatform() : super(token: _token);

  static final Object _token = Object();

  static SimpleFileSaverPlatform _instance = MethodChannelSimpleFileSaver();

  /// The default instance of [SimpleFileSaverPlatform] to use.
  ///
  /// Defaults to [MethodChannelSimpleFileSaver].
  static SimpleFileSaverPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [SimpleFileSaverPlatform] when they register themselves.
  static set instance(SimpleFileSaverPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Save the file to the default location.
  Future<bool?> saveFile({
    required Uint8List dataBytes,
    required String fileName,
    String? mimeType,
  }) {
    throw UnimplementedError('saveFile() has not been implemented.');
  }

  /// Prompt to the users and save the file to the specified location.
  Future<bool?> saveFileAs({
    required Uint8List dataBytes,
    required String fileName,
    String? mimeType,
  }) {
    throw UnimplementedError('saveFileAs() has not been implemented.');
  }
}
