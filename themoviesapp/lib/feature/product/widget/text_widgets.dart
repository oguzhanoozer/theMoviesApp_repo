import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:themoviesapp/product/constants/application_constants.dart';

class BodyMediumText extends Text {
  final String data;
  final BuildContext context;
  BodyMediumText(this.data, this.context)
      : super(
          data,
          style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: ApplicationConstants.instance.whiteColor),
        );
}

class HeadLineText extends Text {
  final String data;
  final BuildContext context;
  HeadLineText(this.data, this.context)
      : super(data,
            style: context.textTheme.headline6?.copyWith(
                fontWeight: FontWeight.bold,
                color: ApplicationConstants.instance.whiteColor));
}
