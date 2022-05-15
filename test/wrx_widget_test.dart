import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_rx/exception/stream_exception.dart';
import 'package:widget_rx/widget_rx.dart';

void main() {
  testWidgets('Test Wrx when onWaiting return CircularProgressIndicator widget',
      (WidgetTester tester) async {
    final StreamController<String> controller = StreamController<String>();

    final widgetToTest = Wrx<String, StreamException>(
      stream: controller.stream,
      onWaiting: () => const CircularProgressIndicator(),
    );

    await tester.pumpWidget(widgetToTest);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
  testWidgets('Test Wrx when onSuccess  return Text widget  with initialData',
      (WidgetTester tester) async {
    final StreamController<String> controller = StreamController<String>();

    const String textToTest = 'Hello World';

    final widgetToTest = Wrx<String, StreamException>(
      initialData: textToTest,
      stream: controller.stream,
      onSuccess: (value) => Text(value, textDirection: TextDirection.ltr),
    );

    await tester.pumpWidget(widgetToTest);

    await tester.pump();

    expect(find.byType(Text), findsOneWidget);
    expect(find.text(textToTest), findsOneWidget);
  });
  testWidgets(
      'Test Wrx when onSuccess return Text widget when send data by stream',
      (WidgetTester tester) async {
    final StreamController<String> controller = StreamController<String>();

    const String textToTest = 'Hello World';

    controller.sink.add(textToTest);

    final widgetToTest = Wrx<String, StreamException>(
      stream: controller.stream,
      onSuccess: (value) => Text(value, textDirection: TextDirection.ltr),
    );

    await tester.pumpWidget(widgetToTest);

    await tester.pump();

    expect(find.byType(Text), findsOneWidget);
    expect(find.text(textToTest), findsOneWidget);
  });

  testWidgets(
      'Test Wrx when onError return Text widget when send error by stream',
      (WidgetTester tester) async {
    final StreamController<String> controller = StreamController<String>();

    const String textToTest = 'Stream error';

    controller.sink.addError(StreamException(textToTest));

    final widgetToTest = Wrx<String, StreamException<String>>(
      stream: controller.stream,
      onError: (error) => Text(error.data, textDirection: TextDirection.ltr),
    );

    await tester.pumpWidget(widgetToTest);

    await tester.pump();

    expect(find.byType(Text), findsOneWidget);
    expect(find.text(textToTest), findsOneWidget);
  });

  testWidgets('Test Wrx when onSuccess, onError and onWaiting are null',
      (WidgetTester tester) async {
    final StreamController<String> controller = StreamController<String>();

    final widgetToTest = Wrx<String, StreamException<String>>(
      stream: controller.stream,
    );

    await tester.pumpWidget(widgetToTest);

    await tester.pump();

    expect(find.byType(SizedBox), findsOneWidget);
  });
}
