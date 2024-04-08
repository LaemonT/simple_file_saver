import 'dart:convert';
import 'dart:ui_web';

import 'package:flutter/material.dart';

import 'package:simple_file_saver_platform_interface/simple_file_saver_platform_interface.dart';

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
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SimpleFileSaverPlatform.instance.webOnlyBytesDownloadLinkBuilder(
                    dataBytes: utf8.encode('Simple file saver test'),
                    builder: (context, startDownload) => TextButton(
                      child: const Text('Download by Bytes'),
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
                  child: SimpleFileSaverPlatform.instance.webOnlyUriDownloadLinkBuilder(
                    uri: Uri.parse(
                      AssetManager().getAssetUrl('sample.pdf'),
                    ),
                    fileName: 'pdf_file_sample',
                    builder: (context, startDownload) => TextButton(
                      child: const Text('Download by Uri (from assets)'),
                      onPressed: () async {
                        startDownload.call();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('File download by uri.'),
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
                  child: SimpleFileSaverPlatform.instance.webOnlyUriDownloadLinkBuilder(
                    uri: Uri.parse(
                        'https://cdn.glitch.me/4c9ebeb9-8b9a-4adc-ad0a-238d9ae00bb5%2Fmdn_logo-only_color.svg'),
                    fileName: 'test_file_dl.svg',
                    builder: (context, startDownload) => TextButton(
                      child: const Text('Download by Uri (from remote)'),
                      onPressed: () async {
                        startDownload.call();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('File download by uri.'),
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
