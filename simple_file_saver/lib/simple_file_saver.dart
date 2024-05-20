import 'package:flutter/widgets.dart';
import 'package:simple_file_saver_platform_interface/simple_file_saver_platform_interface.dart';

export 'package:simple_file_saver_platform_interface/simple_file_saver_platform_interface.dart';

class SimpleFileSaver {
  SimpleFileSaver._();

  /// Save to the default location silently or prompt the user to save as.
  ///
  /// Android defaults to the downloads directory.
  ///
  /// iOS defaults to the documents directory, requires setting the 'Supports Document Browser' key
  /// to YES in the info.plist to reveal the directory to the other apps.
  ///
  /// saveAs has no effect on the web, since it depends on the browser's setting.
  static Future<String?> saveFile({
    required FileSaveInfo fileInfo,
    bool saveAs = false,
  }) {
    return SimpleFileSaverPlatform.instance.saveFile(
      fileInfo: fileInfo,
      saveAs: saveAs,
    );
  }

  /// Build a Link widget to enable the right click option 'save link as' on the web platform
  ///
  /// This method only implemented on the web platform
  static Widget downloadLinkBuilder({
    required FileSaveInfo fileInfo,
    LinkTarget target = LinkTarget.blank,
    required DownloadLinkBuilder builder,
  }) {
    return SimpleFileSaverPlatform.instance.downloadLinkBuilder(
      fileInfo: fileInfo,
      target: target,
      builder: builder,
    );
  }
}
