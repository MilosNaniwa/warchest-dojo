import 'package:flutter/widgets.dart';

class StatefulWrapper extends StatefulWidget {
  const StatefulWrapper({
    super.key,
    required this.onInit,
    required this.child,
  });
  final void Function() onInit;
  final Widget child;

  @override
  StatefulWrapperState createState() => StatefulWrapperState();
}

class StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    super.initState();
    widget.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
