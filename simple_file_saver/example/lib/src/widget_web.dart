import 'dart:convert';
import 'dart:ui_web';

import 'package:flutter/material.dart';
import 'package:simple_file_saver/simple_file_saver.dart';

Widget buildWidget(BuildContext context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: SimpleFileSaver.webOnlyBytesDownloadLinkBuilder(
            dataBytes: utf8.encode('Simple file saver test'),
            builder: (_, startDownload) => TextButton(
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
          child: SimpleFileSaver.webOnlyUriDownloadLinkBuilder(
            uri: Uri.parse(
              AssetManager().getAssetUrl('sample.pdf'),
            ),
            fileName: 'pdf_file_sample',
            builder: (_, startDownload) => TextButton(
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
          child: SimpleFileSaver.webOnlyUriDownloadLinkBuilder(
            uri: Uri.parse('https://cdn.glitch.me/4c9ebeb9-8b9a-4adc-ad0a-238d9ae00bb5%2Fmdn_logo-only_color.svg'),
            fileName: 'test_file_dl.svg',
            builder: (_, startDownload) => TextButton(
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
    );
