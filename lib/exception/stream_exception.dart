class StreamException<E> implements Exception {
  StreamException(this.data);

  final E data;
}
