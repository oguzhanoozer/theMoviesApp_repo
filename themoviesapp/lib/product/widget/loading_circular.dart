import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kartal/kartal.dart';

import '../constants/application_constants.dart';

class LoadingCircularProduct extends StatelessWidget {
  const LoadingCircularProduct({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return CircularProgressIndicator(
          color: ApplicationConstants.instance.whiteColor,
          strokeWidth: context.lowValue);
    }
    return CupertinoActivityIndicator(
        radius: context.mediumValue, animating: true);
  }
}
