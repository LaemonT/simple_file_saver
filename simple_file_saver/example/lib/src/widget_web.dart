import 'dart:convert';
import 'dart:ui_web';

import 'package:flutter/material.dart';
import 'package:simple_file_saver/simple_file_saver.dart';

Widget buildWidget(BuildContext context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: SimpleFileSaver.downloadLinkBuilder(
            fileInfo: FileSaveInfo.fromBytes(
              bytes: utf8.encode('Simple file saver test'),
              basename: 'test_save',
              extension: 'txt',
            ),
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
          child: SimpleFileSaver.downloadLinkBuilder(
            fileInfo: FileSaveInfo.fromUrl(
              url: AssetManager().getAssetUrl('sample.pdf'),
              basename: 'pdf_file_sample',
              extension: 'pdf',
            ),
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
          child: SimpleFileSaver.downloadLinkBuilder(
            fileInfo: FileSaveInfo.fromUrl(
              url: 'https://picsum.photos/id/237/200/300',
              basename: 'test_file_dl',
              extension: 'jpg',
            ),
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
