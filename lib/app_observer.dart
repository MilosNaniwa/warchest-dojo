import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:warchest_dojo/const/environment_const.dart';
import 'package:warchest_dojo/global.dart';
import 'package:warchest_dojo/log.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    Log.info(
      message: '${bloc.runtimeType}: {\n'
          '\tcurrentState: ${change.currentState},\n'
          '\tnextState: ${change.nextState}\n'
          '}',
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    Log.wtf(
      message: 'onError(${bloc.runtimeType})',
      error: error,
      stackTrace: stackTrace,
    );
    if ([
      EnvironmentConst.prod,
      EnvironmentConst.stage,
    ].contains(globalEnvironment)) {
      Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );
    }
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  // エラー発生時の挙動を定義
  FlutterError.onError = (details) {
    Log.wtf(
      message: 'Error',
      error: details.exception,
      stackTrace: details.stack!,
    );
    if ([
      EnvironmentConst.prod,
      EnvironmentConst.stage,
    ].contains(globalEnvironment)) {
      Sentry.captureException(
        details.exception,
        stackTrace: details.stack!,
      );
    }
  };

  Bloc.observer = AppBlocObserver();

  runApp(await builder());
}
