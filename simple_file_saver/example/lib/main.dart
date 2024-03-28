import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simple_file_saver/simple_file_saver.dart';

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
                  child: const Text('Click to save file'),
                  onPressed: () async {
                    final result = await SimpleFileSaver.saveFile(
                      dataBytes: utf8.encode('Simple file saver test'),
                      fileName: 'test.txt',
                      mimeType: 'text/plain',
                    );
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('File saved? $result'),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextButton(
                  child: const Text('Click to save file as...'),
                  onPressed: () async {
                    final result = await SimpleFileSaver.saveFileAs(
                      dataBytes: utf8.encode('Simple file saver test'),
                      fileName: 'test_save_as.txt',
                      mimeType: 'text/plain',
                    );
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('File saved? $result'),
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
