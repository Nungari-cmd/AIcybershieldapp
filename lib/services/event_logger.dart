class EventLogger {
  static final List<String> _logs = [];

  static void log(String message) {
    _logs.add(
      "${DateTime.now().toString()} : $message",
    );
  }

  static List<String> getLogs() {
    return _logs;
  }
}