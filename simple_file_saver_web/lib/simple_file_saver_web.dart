import 'dart:js_interop';
import 'dart:typed_data';

import 'package:fetch_client/fetch_client.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:simple_file_saver_platform_interface/simple_file_saver_platform_interface.dart';
import 'package:web/web.dart' as web;

class SimpleFileSaverPlugin extends SimpleFileSaverPlatform {
  static void registerWith(Registrar registrar) {
    SimpleFileSaverPlatform.instance = SimpleFileSaverPlugin();
  }

  @override
  Future<String?> saveFile({
    required FileSaveInfo fileInfo,
    bool saveAs = false,
  }) async {
    final String blobUrl;
    switch (fileInfo) {
      case FileBytesInfo fileInfo:
        // Make file download url from bytes
        blobUrl = makeBlobDownloadUrl(fileInfo.bytes, fileInfo.mimeType);
        break;
      case FileUrlInfo fileInfo:
        // Fetch data and download from local blob to avoid opening the url due to cross origin access.
        final dataBytes = await fetchData(fileInfo);
        // Make file download url from bytes
        blobUrl = makeBlobDownloadUrl(dataBytes, fileInfo.mimeType);
        break;
      default:
        throw 'Undefined type.';
    }

    // Download the file from blobUrl
    download(blobUrl, fileInfo);

    return 'The file save method on the web platform depends on the browser, so the path is not available.';
  }

  @override
  Widget downloadLinkBuilder({
    required FileSaveInfo fileInfo,
    LinkTarget target = LinkTarget.blank,
    required DownloadLinkBuilder builder,
  }) {
    switch (fileInfo) {
      case FileBytesInfo fileInfo:
        // Make file download url from bytes
        final blobUrl = makeBlobDownloadUrl(fileInfo.bytes, fileInfo.mimeType);
        // Build a Link widget
        return Link(
          uri: Uri.parse(blobUrl),
          target: target,
          builder: (context, _) => builder.call(
            context,
            () {
              // Download the file from blobUrl
              download(blobUrl, fileInfo);
            },
          ),
        );
      case FileUrlInfo fileInfo:
        // Build a Link widget
        return Link(
          uri: fileInfo.uri,
          target: target,
          builder: (context, _) => builder.call(
            context,
            () async {
              // Fetch data and download from local blob to avoid opening the url due to cross origin access.
              final dataBytes = await fetchData(fileInfo);

              // Make file download url from bytes
              final blobUrl = makeBlobDownloadUrl(dataBytes, fileInfo.mimeType);

              // Download the file from blobUrl
              download(blobUrl, fileInfo);
            },
          ),
        );
      default:
        throw 'Undefined type.';
    }
  }

  // This method is required since "download only works for same-origin URLs, or the blob: and data: schemes."
  Future<Uint8List> fetchData(
    FileUrlInfo fileInfo,
  ) {
    // Fetch the resource data bytes
    return FetchClient(
      mode: RequestMode.cors,
    ).readBytes(fileInfo.uri);
  }

  String makeBlobDownloadUrl(Uint8List dataBytes, String? mimeType) {
    // Create the file object locally
    final blob = mimeType == null
        ? web.Blob([dataBytes.toJS].toJS)
        : web.Blob([dataBytes.toJS].toJS, web.BlobPropertyBag(type: mimeType));

    // Create resource URL from the BLOB
    return web.URL.createObjectURL(blob);
  }

  void download(
    String blobUrl,
    FileSaveInfo fileInfo,
  ) {
    // Create an anchor element and simulate a click action
    // https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a#href
    web.HTMLAnchorElement()
      ..href = blobUrl
      // https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a#download
      ..download = fileInfo.filenameWithExtension
      // https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a#target
      ..target = 'blank'
      ..click()
      ..remove();

    // Cleanup
    web.URL.revokeObjectURL(blobUrl);
  }
}
