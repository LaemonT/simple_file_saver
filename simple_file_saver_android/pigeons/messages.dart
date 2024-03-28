import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    input: 'pigeons/messages.dart',
    dartOut: 'lib/messages.g.dart',
    kotlinOut: 'android/src/main/kotlin/com/laemont/simple_file_saver/Messages.g.kt',
    kotlinOptions: KotlinOptions(
      package: 'com.laemont.simple_file_saver',
    ),
  ),
)
@HostApi()
abstract class SimpleFileSaverApi {
  @async
  bool? saveFile({
    required Uint8List dataBytes,
    required String fileName,
    String? mimeType,
  });

  @async
  bool? saveFileAs({
    required Uint8List dataBytes,
    required String fileName,
    String? mimeType,
  });
}
