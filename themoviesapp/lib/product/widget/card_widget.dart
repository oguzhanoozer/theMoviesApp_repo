import 'package:flutter/material.dart';

class CardWidget extends Card {
  CardWidget({required this.child, super.key, this.marginValue})
      : super(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            margin: marginValue ?? EdgeInsets.zero);

  final Widget child;
  final EdgeInsets? marginValue;
}
