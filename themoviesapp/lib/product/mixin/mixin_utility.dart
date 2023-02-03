import 'package:flutter/material.dart';

mixin SnackBarWidgetMixin {
  BuildContext get currentContext;
  void buildSnackBar() {
    final snackBar = SnackBar(
      content: const Text('Yay! A SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(currentContext).showSnackBar(snackBar);
  }
}
