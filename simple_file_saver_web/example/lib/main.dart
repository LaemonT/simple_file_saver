import 'dart:convert';
import 'dart:ui_web';

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
                  child: const Text('Click to save file from bytes'),
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
                          content: Text('File download by bytes:\n$result'),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextButton(
                  child: const Text('Click to save file from URL'),
                  onPressed: () async {
                    final result = await SimpleFileSaverPlatform.instance.saveFile(
                      fileInfo: FileSaveInfo.fromUrl(
                        url: testUrl,
                        basename: 'test_save_from_url',
                      ),
                    );
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('File download by bytes:\n$result'),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SimpleFileSaverPlatform.instance.downloadLinkBuilder(
                    fileInfo: FileSaveInfo.fromBytes(
                      bytes: utf8.encode('Simple file saver test'),
                      basename: 'test_dl_from_bytes',
                      extension: 'txt',
                    ),
                    builder: (context, startDownload) => TextButton(
                      child: const Text('Download link from bytes'),
                      onPressed: () async {
                        startDownload.call();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('File download by bytes.'),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SimpleFileSaverPlatform.instance.downloadLinkBuilder(
                    fileInfo: FileSaveInfo.fromUrl(
                      url: AssetManager().getAssetUrl('sample.pdf'),
                      basename: 'test_dl_from_local_url',
                    ),
                    builder: (context, startDownload) => TextButton(
                      child: const Text('Download link from URL (local asset)'),
                      onPressed: () async {
                        startDownload.call();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('File download by URL.'),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SimpleFileSaverPlatform.instance.downloadLinkBuilder(
                    fileInfo: FileSaveInfo.fromUrl(
                      url: testUrl,
                      basename: 'test_dl_from_remote_url',
                    ),
                    builder: (context, startDownload) => TextButton(
                      child: const Text('Download link from URL (remote resource)'),
                      onPressed: () async {
                        startDownload.call();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('File download by URL.'),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
