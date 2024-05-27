import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_file_saver/simple_file_saver.dart';

import 'conditional_widget.dart';

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
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Simple File Saver Demo'),
          ),
          body: Builder(
            builder: (context) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildWidget(context),
                  const SizedBox(height: 20),
                  TextButton(
                    child: const Text('Test file save from assets'),
                    onPressed: () async {
                      final byteData = await rootBundle.load("assets/sample.pdf");
                      final result = await SimpleFileSaver.saveFile(
                        fileInfo: FileSaveInfo.fromBytes(
                          bytes: byteData.buffer.asUint8List(),
                          basename: 'pdf_file_sample',
                          extension: 'pdf',
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
            ),
          ),
        ),
      );
}
