import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:warchest_dojo/global.dart';
import 'package:warchest_dojo/view/title_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static FirebaseAnalytics googleAnalytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver googleObserver = FirebaseAnalyticsObserver(
    analytics: googleAnalytics,
  );
  static SentryNavigatorObserver sentryObserver = SentryNavigatorObserver();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: globalLanguageCode == "ja" ? '戦箱道場' : "WarChest Dojo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Yuji Syuku",
      ),
      navigatorObservers: [
        sentryObserver,
        googleObserver,
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja', 'JP'),
      ],
      home: const TitlePage(),
    );
  }
}
