import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    input: 'pigeons/messages.dart',
    dartOut: 'lib/messages.g.dart',
    swiftOut: 'ios/Classes/messages.g.swift',
  ),
)
@HostApi()
abstract class SimpleFileSaverApi {
  String getDocumentDirectory();

  @async
  String? saveFileAs({
    required Uint8List dataBytes,
    required String filenameWithExtension,
  });
}
