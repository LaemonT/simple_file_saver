import 'dart:typed_data';

import 'package:path/path.dart' as path;

import '../utils/mime_converter.dart';

abstract class FileSaveInfo {
  final String basename;
  final String extension;
  final String? mimeType;

  String get filenameWithExtension => extension.length > 1 ? '$basename$extension' : basename;

  FileSaveInfo._fromBytes({
    required Uint8List bytes,
    required this.basename,
    required String extension,
  })  : extension = extension.startsWith('.') == false ? '.$extension' : extension,
        mimeType = mimeTypeLookup(path: extension, dataBytes: bytes);

  FileSaveInfo._fromUrl({
    required String url,
    String? basename,
    String? extension,
  })  : basename = basename ?? path.basenameWithoutExtension(url),
        extension = (extension?.startsWith('.') == false ? '.$extension' : extension) ?? path.extension(url),
        mimeType = mimeTypeLookup(path: url);

  factory FileSaveInfo.fromBytes({
    required Uint8List bytes,
    required String basename,
    required String extension,
  }) {
    return FileBytesInfo._(
      bytes: bytes,
      basename: basename,
      extension: extension,
    );
  }

  factory FileSaveInfo.fromUrl({
    required String url,
    String? basename,
    String? extension,
  }) {
    return FileUrlInfo._(
      url: url,
      basename: basename,
      extension: extension,
    );
  }
}

class FileBytesInfo extends FileSaveInfo {
  final Uint8List bytes;

  FileBytesInfo._({
    required this.bytes,
    required super.basename,
    required super.extension,
  }) : super._fromBytes(bytes: bytes);
}

class FileUrlInfo extends FileSaveInfo {
  final String url;

  Uri get uri => Uri.parse(url);

  FileUrlInfo._({
    required this.url,
    super.basename,
    super.extension,
  }) : super._fromUrl(url: url);
}
