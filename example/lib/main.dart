// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:widget_rx/widget_rx.dart';
import 'package:widget_rx/exception/stream_exception.dart';

void main() => runApp(
      const Init(),
    );

class Init extends StatelessWidget {
  const Init({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Widget Reactive',
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final StreamController<String> streamController =
        StreamController<String>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Wrx'),
      ),
      body: Center(
        child: Wrx<String, StreamException<String>>(
          stream: streamController.stream,
          onSuccess: (value) {
            return Text(value);
          },
          onError: (error) {
            return Text(error.data);
          },
          onWaiting: () {
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
