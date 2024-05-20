# simple_file_saver

[![pub package](https://img.shields.io/pub/v/simple_file_saver.svg)](https://pub.dev/packages/simple_file_saver)


A Flutter plugin that allows you to save files to a public or shared directory such as 
the Downloads folder in Android and Files in iOS.

## Usage

To use this plugin, add `simple_file_saver` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

## Example

```dart
final result = await SimpleFileSaver.saveFile(
    fileInfo: FileSaveInfo.fromBytes(
        bytes: utf8.encode('This file is saved to the default directory'),
        basename: 'file_save',
        extension: 'txt',
    ),
);

final result = await SimpleFileSaver.saveFile(
    fileInfo: FileSaveInfo.fromBytes(
        bytes: utf8.encode('This file is saved to the user picked directory'),
        basename: 'file_save_as',
        extension: 'txt',
    ),
    saveAs: true,
);

SimpleFileSaver.downloadLinkBuilder(
    fileInfo: FileSaveInfo.fromUrl(
        url: 'https://picsum.photos/id/237/200/300',
        basename: 'test_file_dl',
        extension: 'jpg',
    ),
    builder: (_, startDownload) => TextButton(
        child: const Text('Download by Uri (from remote)'),
        onPressed: () async {
            startDownload.call();
        },
    ),
),
```
