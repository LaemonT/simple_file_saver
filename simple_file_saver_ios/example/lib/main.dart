import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:simple_file_saver_platform_interface/simple_file_saver_platform_interface.dart';

const testUrl = 'https://cdn.glitch.me/4c9ebeb9-8b9a-4adc-ad0a-238d9ae00bb5%2Fmdn_logo-only_color.svg';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Simple File Saver Demo'),
        ),
        body: Builder(builder: (context) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  child: const Text('Click to save file (from bytes)'),
                  onPressed: () async {
                    final result = await SimpleFileSaverPlatform.instance.saveFile(
                      fileInfo: FileSaveInfo.fromBytes(
                        bytes: utf8.encode('Simple file saver test'),
                        basename: 'test_save_from_bytes',
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
                  child: const Text('Click to save file as... (from bytes)'),
                  onPressed: () async {
                    final result = await SimpleFileSaverPlatform.instance.saveFile(
                      fileInfo: FileSaveInfo.fromBytes(
                        bytes: utf8.encode('Simple file saver test'),
                        basename: 'test_save_as_from_bytes',
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
                const SizedBox(height: 20),
                TextButton(
                  child: const Text('Click to save file (from URL)'),
                  onPressed: () async {
                    final result = await SimpleFileSaverPlatform.instance.saveFile(
                      fileInfo: FileSaveInfo.fromUrl(
                        url: testUrl,
                        basename: 'test_save_from_url',
                        extension: 'svg',
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
                  child: const Text('Click to save file as... (from URL)'),
                  onPressed: () async {
                    final result = await SimpleFileSaverPlatform.instance.saveFile(
                      fileInfo: FileSaveInfo.fromUrl(
                        url: testUrl,
                        basename: 'test_save_as_from_url',
                        extension: 'svg',
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
            ),
          );
        }),
      ),
    );
  }
}
