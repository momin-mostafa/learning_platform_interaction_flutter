import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _platform = MethodChannel('demo.tamim.com/learn');

  String _message = "no message yet";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_message',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getStringAndShow,
        tooltip: 'call native code',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<String> _getMessageFromPlatform() async {
    Map<String, dynamic> sendMap = {
      'from': 'tamim',
    };
    try {
      String value = await _platform.invokeMethod("getMessage", sendMap);
      return value;
    } catch (e) {
      log(e.toString(), error: "ERROR._getMessageFromPlatform");
      throw "ERROR while method invoke";
    }
  }

  Future<void> getStringAndShow() async {
    await _getMessageFromPlatform().then((value) {
      setState(() {
        _message = value;
      });
    });
  }
}
