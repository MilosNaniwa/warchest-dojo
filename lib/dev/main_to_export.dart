import 'package:flutter/material.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:warchest_dojo/dev/app_to_export.dart';

void main() {
  Chain.capture(
    () => runApp(
      const AppToExport(),
    ),
  );
}
