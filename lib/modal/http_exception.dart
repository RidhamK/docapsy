class HttpExtentions implements Exception {
  final String message;
  HttpExtentions(this.message);

  @override
  String toString() {
    return message;
    // return super.toString();
  }
}
