import 'package:flutter/material.dart';

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
              child: buildWidget(context),
            ),
          ),
        ),
      );
}
