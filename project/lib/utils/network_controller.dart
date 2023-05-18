import 'package:flutter/material.dart';

class ConnectionNotifier extends InheritedNotifier<ValueNotifier<bool>> {

  ConnectionNotifier({required super.child, super.key, required super.notifier});

  static ValueNotifier<bool> of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ConnectionNotifier>()!.notifier!;
  }

}