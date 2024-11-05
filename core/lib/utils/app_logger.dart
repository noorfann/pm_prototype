import 'package:logger/logger.dart';

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  late Logger _logger;

  factory AppLogger() {
    return _instance;
  }

  AppLogger._internal() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2, // number of method calls to be displayed
        errorMethodCount: 8, // number of method calls if stacktrace is provided
        lineLength: 120, // width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        dateTimeFormat: DateTimeFormat.dateAndTime,
      ),
    );
  }

  void logInfo(String message) {
    if (isDebugMode()) {
      _logger.i(message);
    }
  }

  void logDebug(String message) {
    if (isDebugMode()) {
      _logger.d(message);
    }
  }

  void logError(String message, [dynamic error, StackTrace? stackTrace]) {
    if (isDebugMode()) {
      _logger.e(message, error: error, stackTrace: stackTrace);
    }
  }

  void logWarning(String message) {
    if (isDebugMode()) {
      _logger.w(message);
    }
  }

  bool isDebugMode() {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }
}

AppLogger logger = AppLogger();
