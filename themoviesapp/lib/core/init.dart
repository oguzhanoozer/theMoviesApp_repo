import 'package:flutter/material.dart';
import 'package:themoviesapp/product/widget/empty_sizedbox_shrink.dart';
import '../network/network_change/no_network_widget.dart';

class MainBuild {
  MainBuild._();
  static Widget build(BuildContext context, Widget? child) {
    return Column(
      children: [
        Expanded(child: child ?? const EmptySizedBoxShrink()),
        const NoNetworkWidget(),
      ],
    );
  }
}
