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
  @async
  bool saveFile({
    required Uint8List dataBytes,
    required String fileName,
  });

  @async
  bool saveFileAs({
    required Uint8List dataBytes,
    required String fileName,
  });
}
