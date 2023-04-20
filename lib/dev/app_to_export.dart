import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:warchest_dojo/dev/widget_to_image.dart';

class AppToExport extends StatelessWidget {
  const AppToExport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '戦箱道場',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Yuji Syuku",
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja', 'JP'),
      ],
      home: const WidgetToImagePage(),
    );
  }
}
