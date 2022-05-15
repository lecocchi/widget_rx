## Wrx

The Flutter Widget that wraps the stream builder and makes it easy to use.

### Getting started

1. Add dependency to your pubspec.yaml
```
dependencies:
   widget_rx: ^1.0.0
   ```
2. Import it
```
import 'package:widget_rx/widget_rx.dart';
```

### Conditions

- **onSuccess** = if snapshot.hasData is true
- **onError** = if snapshot.hasError is true
- **onWaiting** = if snapshot.hasData is false


If you want to indicate the data type when it is a success or an error, you need to add the data types as generics Wrx<S, E>
- S (Data type when success)
- E (Data type when is error)

The package has a class for the error type (StreamException), which receives a generic to indicate the type of error data that you want to use (See example)

### Example

```
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
```
