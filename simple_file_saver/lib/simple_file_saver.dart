import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:simple_file_saver_platform_interface/simple_file_saver_platform_interface.dart';

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
  }) {
    return _platform.saveFile(
      dataBytes: dataBytes,
      fileName: fileName,
      mimeType: mimeType,
    );
  }

  /// Prompt to the users and save the file to the specified location.
  static Future<bool> saveFileAs({
    required Uint8List dataBytes,
    required String fileName,
    String? mimeType,
  }) {
    return _platform.saveFileAs(
      dataBytes: dataBytes,
      fileName: fileName,
      mimeType: mimeType,
    );
  }

  /// Download the file by bytes.
  static Future<void> downloadFileByBytes({
    required Uint8List dataBytes,
    String? fileName,
  }) {
    return _platform.downloadFileByBytes(
      dataBytes: dataBytes,
      fileName: fileName,
    );
  }

  /// Download the file by uri.
  static Future<void> downloadFileByUri({
    required Uri uri,
    String? fileName,
  }) {
    return _platform.downloadFileByUri(
      uri: uri,
      fileName: fileName,
    );
  }

  /// Build a Link widget for the web only, and download the file by bytes
  static Widget webOnlyBytesDownloadLinkBuilder({
    required Uint8List dataBytes,
    String? fileName,
    LinkTarget target = LinkTarget.blank,
    required DownloadLinkBuilder builder,
  }) {
    return _platform.webOnlyBytesDownloadLinkBuilder(
      dataBytes: dataBytes,
      fileName: fileName,
      target: target,
      builder: builder,
    );
  }

  /// Build a Link widget for the web only, and download the file by Uri
  static Widget webOnlyUriDownloadLinkBuilder({
    required Uri uri,
    String? fileName,
    LinkTarget target = LinkTarget.blank,
    required DownloadLinkBuilder builder,
  }) {
    return _platform.webOnlyUriDownloadLinkBuilder(
      uri: uri,
      fileName: fileName,
      target: target,
      builder: builder,
    );
  }
}
