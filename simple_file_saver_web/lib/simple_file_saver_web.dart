import 'dart:html' as html;
import 'dart:typed_data';

import 'package:fetch_client/fetch_client.dart' as fetch_api;
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:mime/mime.dart' as mime;
import 'package:path/path.dart' as path;
import 'package:simple_file_saver_platform_interface/simple_file_saver_platform_interface.dart';

class SimpleFileSaverPlugin extends SimpleFileSaverPlatform {
  static void registerWith(Registrar registrar) {
    SimpleFileSaverPlatform.instance = SimpleFileSaverPlugin();
  }

  @override
  Future<void> downloadFileByBytes({
    required Uint8List dataBytes,
    String? fileName,
  }) async {
    // Create a blob from bytes
    final blob = makeBlob(dataBytes);

    // Create file url
    final url = makeUrl(blob);

    // Download the file from url
    download(url, blob.type, fileName);
  }

  @override
  Future<void> downloadFileByUri({
    required Uri uri,
    String? fileName,
  }) async {
    // Fetch data from the uri
    final dataBytes = await fetchData(uri);

    // Create a blob from bytes
    final blob = makeBlob(dataBytes);

    // Create file url
    final url = makeUrl(blob);

    // Download the file from url
    download(url, blob.type, fileName ?? uri.pathSegments.last);
  }

  @override
  Widget webOnlyBytesDownloadLinkBuilder({
    required Uint8List dataBytes,
    String? fileName,
    LinkTarget target = LinkTarget.defaultTarget,
    required DownloadLinkBuilder builder,
  }) {
    // Create a blob from bytes
    final blob = makeBlob(dataBytes);

    // Create file url
    final url = makeUrl(blob);

    // Build a Link widget
    return Link(
      uri: Uri.parse(url),
      target: target,
      builder: (context, _) => builder.call(
        context,
        () {
          download(url, blob.type, fileName);
        },
      ),
    );
  }

  @override
  Widget webOnlyUriDownloadLinkBuilder({
    required Uri uri,
    String? fileName,
    LinkTarget target = LinkTarget.defaultTarget,
    required DownloadLinkBuilder builder,
  }) {
    // Build a Link widget
    return Link(
      uri: uri,
      target: target,
      builder: (context, _) => builder.call(
        context,
        () async {
          // Fetch data from the uri
          final dataBytes = await fetchData(uri);

          // Create a blob from bytes
          final blob = makeBlob(dataBytes);

          // Create file url
          final url = makeUrl(blob);

          // Download
          download(url, blob.type, fileName);
        },
      ),
    );
  }

  Future<Uint8List> fetchData(Uri uri) {
    // Fetch the resource data bytes
    return fetch_api.FetchClient(
      mode: fetch_api.RequestMode.cors,
    ).readBytes(uri);
  }

  html.Blob makeBlob(Uint8List dataBytes) {
    // Find the MIME type of the file
    final mimeType = mime.lookupMimeType(
      '',
      headerBytes: dataBytes.sublist(0, mime.defaultMagicNumbersMaxLength),
    );

    // Create the file object locally
    return html.Blob([dataBytes], mimeType);
  }

  String makeUrl(html.Blob blob) {
    // Create resource URL from the BLOB
    return html.Url.createObjectUrlFromBlob(blob);
  }

  void download(
    String url,
    String type,
    String? fileName,
  ) {
    // Make the file name and the extension
    final name = fileName == null ? url.split('/').last : path.basenameWithoutExtension(fileName);
    final extension = path.extension(
      fileName ?? mime.extensionFromMime(type),
    );
    final downloadFileName = extension.length > 1 ? '$name$extension' : name;

    // Create an anchor element and simulate a click action
    html.AnchorElement(href: url) // https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a#href
      ..download = downloadFileName // https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a#download
      ..target = 'blank' // https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a#target
      ..click()
      ..remove();

    // Cleanup
    html.Url.revokeObjectUrl(url);
  }
}
