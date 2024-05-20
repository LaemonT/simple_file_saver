import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simple_file_saver/simple_file_saver.dart';

Widget buildWidget(BuildContext context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          child: const Text('Click to save file'),
          onPressed: () async {
            final result = await SimpleFileSaver.saveFile(
              fileInfo: FileSaveInfo.fromBytes(
                bytes: utf8.encode('Simple file saver test'),
                basename: 'test_save',
                extension: 'txt',
              ),
            );
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('File saved to path: $result'),
                ),
              );
            }
          },
        ),
        const SizedBox(height: 20),
        TextButton(
          child: const Text('Click to save file as...'),
          onPressed: () async {
            final result = await SimpleFileSaver.saveFile(
              fileInfo: FileSaveInfo.fromBytes(
                bytes: utf8.encode('Simple file saver test'),
                basename: 'test_save_as',
                extension: 'txt',
              ),
              saveAs: true,
            );
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('File saved to path: $result'),
                ),
              );
            }
          },
        ),
      ],
    );
