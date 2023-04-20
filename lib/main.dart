import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:warchest_dojo/app.dart';
import 'package:warchest_dojo/app_observer.dart';
import 'package:warchest_dojo/const/environment_const.dart';
import 'package:warchest_dojo/firebase_config.dart';
import 'package:warchest_dojo/global.dart';
import 'package:warchest_dojo/sentry_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());

  globalEnvironment = const String.fromEnvironment(
    "ENVIRONMENT",
    defaultValue: EnvironmentConst.dev,
  );

  globalLanguageCode = Uri.base.queryParameters["lang"] ?? "en";
  globalKanjiMode = globalLanguageCode == "ja";

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: FirebaseConfig.of(globalEnvironment).apiKey,
      authDomain: FirebaseConfig.of(globalEnvironment).authDomain,
      projectId: FirebaseConfig.of(globalEnvironment).projectId,
      storageBucket: FirebaseConfig.of(globalEnvironment).storageBucket,
      messagingSenderId: FirebaseConfig.of(globalEnvironment).messagingSenderId,
      appId: FirebaseConfig.of(globalEnvironment).appId,
      measurementId: FirebaseConfig.of(globalEnvironment).measurementId,
    ),
  );

  final FirebaseAuth auth = FirebaseAuth.instance;
  await auth.signInAnonymously();

  switch (globalEnvironment) {
    case EnvironmentConst.stage:
    case EnvironmentConst.prod:
      SentryFlutter.init(
        (options) => options
          ..dsn = SentryConfig.of(globalEnvironment).dsn
          ..tracesSampleRate = 1.0
          ..debug = false
          ..environment = globalEnvironment
          ..release = const String.fromEnvironment(
            'SENTRY_RELEASE',
          ),
        appRunner: () => bootstrap(App.new),
      );
      break;
    case EnvironmentConst.dev:
    default:
      bootstrap(App.new);
      break;
  }
}
