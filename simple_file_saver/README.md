# simple_file_saver

[![pub package](https://img.shields.io/pub/v/simple_file_saver.svg)](https://pub.dev/packages/simple_file_saver)


A Flutter plugin that allows you to save files to a public or shared directory such as 
the Downloads folder in Android and Files in iOS.

## Usage

To use this plugin, add `simple_file_saver` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

## Example

```dart
final result = await SimpleFileSaver.saveFile(
    dataBytes: utf8.encode('This file is been saved to the default directory'),
    fileName: 'file_save.txt',
    mimeType: 'text/plain',
);

final result = await SimpleFileSaver.saveFileAs(
    dataBytes: utf8.encode('This file is been saved as...'),
    fileName: 'file_save_as.txt',
    mimeType: 'text/plain',
);
```
