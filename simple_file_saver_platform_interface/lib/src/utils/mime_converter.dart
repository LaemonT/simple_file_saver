import 'dart:typed_data';

import 'package:mime/mime.dart' as mime;

String? extensionFromMimeType(String? mimeType) {
  if (mimeType != null) {
    return mime.extensionFromMime(mimeType);
  }

  return null;
}

/// Attempt to use the extension in resolving the mime type first, and then try the header bytes if it fails
String? mimeTypeLookup({required String path, Uint8List? dataBytes}) {
  return mime.lookupMimeType(
    path,
    headerBytes: dataBytes?.sublist(0, mime.defaultMagicNumbersMaxLength),
  );
}
