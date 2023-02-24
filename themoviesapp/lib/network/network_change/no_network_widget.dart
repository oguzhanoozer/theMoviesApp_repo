import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:themoviesapp/product/constants/application_constants.dart';
import '../../product/widget/empty_sizedbox_shrink.dart';
import 'network_change_manager.dart';

class NoNetworkWidget extends StatefulWidget {
  const NoNetworkWidget({super.key});

  @override
  State<NoNetworkWidget> createState() => _NoNetworkWidgetState();
}

class _NoNetworkWidgetState extends State<NoNetworkWidget> with StateMixin {
  late final INetworkChangeManager _networkChange;
  NetworkResult? _networkResult;
  @override
  void initState() {
    super.initState();
    _networkChange = NetworkChangeManager();

    waitForScreen(() {
      _networkChange.handleNetworkChange((result) {
        _updateView(result);
      });
    });
  }

  Future<void> fetchFirstResult() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final result = await _networkChange.checkNetworkFirstTime();
      _updateView(result);
    });
  }

  void _updateView(NetworkResult result) {
    setState(() {
      _networkResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
        duration: context.durationLow,
        crossFadeState: _networkResult == NetworkResult.off
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstChild: Container(
            height: context.dynamicHeight(0.1),
            color: context.colorScheme.primary,
            child: Center(
              child: FittedBox(
                  child: Text(
                ApplicationConstants.instance.noInternetConnectionText,
                style: context.textTheme.bodyMedium,
              )),
            )),
        secondChild: const EmptySizedBoxShrink());
  }
}

mixin StateMixin<T extends StatefulWidget> on State<T> {
  void waitForScreen(VoidCallback onComplete) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onComplete.call();
    });
  }
}
