import 'package:flutter/widgets.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:url_launcher/link.dart';

import 'src/default_method_channel_platform.dart';
import 'src/types/file_save_info.dart';

export 'package:url_launcher/link.dart';

export 'src/types/file_save_info.dart';

typedef DownloadLinkBuilder = Widget Function(
  BuildContext context,
  VoidCallback startDownload,
);

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

  static SimpleFileSaverPlatform _instance = DefaultSimpleFileSaverPlatform();

  /// The default instance of [SimpleFileSaverPlatform] to use.
  ///
  /// Defaults to [DefaultSimpleFileSaverPlatform].
  static SimpleFileSaverPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [SimpleFileSaverPlatform] when they register themselves.
  static set instance(SimpleFileSaverPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Save file to the default directory.
  Future<String?> saveFile({
    required FileSaveInfo fileInfo,
    bool saveAs = false, // Save to the default location silently or prompt the user to save as.
  }) {
    throw UnimplementedError('saveFile() has not been implemented.');
  }

  /// Build a Link widget to enable the right click option 'save link as' on the web platform
  Widget downloadLinkBuilder({
    required FileSaveInfo fileInfo,
    LinkTarget target = LinkTarget.blank,
    required DownloadLinkBuilder builder,
  }) {
    throw UnimplementedError('downloadLinkBuilder() has not been implemented, and should only be used for web.');
  }
}
