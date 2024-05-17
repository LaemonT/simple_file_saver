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
  String saveToDownloads({
    required Uint8List dataBytes,
    required String filenameWithExtension,
  });

  @async
  String? saveFileAs({
    required Uint8List dataBytes,
    required String filenameWithExtension,
    String? mimeType,
  });
}
