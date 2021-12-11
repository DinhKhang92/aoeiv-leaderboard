import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final int milliseconds;
  late final VoidCallback action;
  late Timer _timer;

  Debouncer({required this.milliseconds}) {
    _timer = Timer(Duration(milliseconds: milliseconds), () => {});
  }

  run(VoidCallback action) {
    _timer.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
