library widget_rx;

import 'package:flutter/widgets.dart';

class Wrx<T, E> extends StatelessWidget {
  const Wrx({
    Key? key,
    @required this.stream,
    this.onSuccess,
    this.onError,
    this.onWaiting,
  })  : assert(stream != null, "stream shouldn't be null"),
        super(key: key);

  final Stream<T>? stream;
  final Widget Function(T value)? onSuccess;
  final Widget Function(E value)? onError;
  final Widget Function()? onWaiting;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (onSuccess != null && snapshot.hasData) {
          return onSuccess!(snapshot.data as T);
        } else if (onError != null && snapshot.hasError) {
          return onError!(snapshot.error as E);
        } else if (onWaiting != null) {
          return onWaiting!();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
