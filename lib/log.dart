import 'package:logger/logger.dart';
import 'package:stack_trace/stack_trace.dart';

class Log {
  static void info({
    required String message,
  }) {
    Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        colors: false,
        printTime: true,
      ),
    ).i(
      message,
    );
  }

  static void wtf({
    required String message,
    required dynamic error,
    required StackTrace stackTrace,
  }) {
    Logger(
      printer: PrettyPrinter(
        colors: false,
        printTime: true,
        errorMethodCount: 20,
      ),
    ).wtf(
      message,
      error,
      Trace.from(stackTrace).terse,
    );
  }

  static void debug({
    required String message,
  }) {
    Logger(
      printer: PrettyPrinter(
        colors: false,
        printTime: true,
      ),
    ).d(
      message,
    );
  }

  static void error({
    required String message,
  }) {
    Logger(
      printer: PrettyPrinter(
        colors: false,
        printTime: true,
      ),
    ).e(
      message,
    );
  }
}
