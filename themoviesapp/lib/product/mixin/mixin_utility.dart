import 'package:flutter/material.dart';
import 'package:themoviesapp/product/constants/application_constants.dart';

mixin SnackBarWidgetMixin {
  BuildContext get currentContext;

  void buildSnackBar() {
    final snackBar = SnackBar(
      content: Text(ApplicationConstants.instance.errorOccured),
      action: SnackBarAction(
        label: ApplicationConstants.instance.okText,
        onPressed: () {
          ScaffoldMessenger.of(currentContext).hideCurrentSnackBar();
        },
      ),
    );

    ScaffoldMessenger.of(currentContext).hideCurrentSnackBar();

    ScaffoldMessenger.of(currentContext).showSnackBar(snackBar);
  }
}
