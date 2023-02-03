import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../product/constants/application_constants.dart';
import 'text_widgets.dart';

class VoteCardWidget extends Card {
  final BuildContext context;
  final String value;
  VoteCardWidget(this.context, this.value, {super.key})
      : super(
            color: ApplicationConstants.instance.greyColor,
            child: Padding(
              padding: context.paddingLow,
              child: BodyMediumText(value, context),
            ));
}
