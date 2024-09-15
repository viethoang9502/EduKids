import 'package:flutter/foundation.dart';

class LogUtils {
  static const bool LOG_MODE = kDebugMode || kProfileMode;

  static const String TAG = "";

  LogUtils();

  static void methodIn({String message = ""}) {
    _outputLog(Level.Trace, '[S]${_outputMessage(message)}');
  }

  static void methodOut({String message = ""}) {
    _outputLog(Level.Trace, '[N]${_outputMessage(message)}');
  }

  static void d(String msg) {
    _outputLog(Level.Debug, _outputMessage(msg));
  }

  static void i(String msg) {
    _outputLog(Level.Info, _outputMessage(msg));
  }

  static void w(String msg) {
    _outputLog(Level.Warn, _outputMessage(msg));
  }

  static void e(String msg) {
    _outputLog(Level.Error, _outputMessage(msg));
  }

  static void _outputLog(Level level, String msg) {
    String msgOut = msg;
    switch (level) {
      case Level.Error:
        msgOut = 'E/$msg';
        break;
      case Level.Warn:
        msgOut = 'W/$msg';
        break;
      case Level.Info:
        msgOut = 'I/$msg';
        break;
      case Level.Debug:
        msgOut = 'D/$msg';
        break;
      case Level.Trace:
        msgOut = 'T/$msg';
        break;
      default:
        break;
    }

    if (LOG_MODE) {
      print('[$TAG]:$msgOut');
    }
  }

  static String _outputMessage(String msg) {
    String stackTrace = StackTrace.current.toString();
    String topStack = stackTrace.split("#2")[1];
    String fileInfo = topStack
        .substring(topStack.indexOf("package"), topStack.indexOf(")"))
        .trim();
    String methodName = topStack.substring(0, topStack.indexOf("(")).trim();
    return '[$methodName]::$msg  <$fileInfo>';
  }
}

enum Level { Error, Warn, Info, Debug, Trace }
