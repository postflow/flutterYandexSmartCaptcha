import 'package:flutter/material.dart';

class OnLoadPlaceholder extends StatelessWidget {
  final Widget? onLoadWidget;
  final bool webViewIsCreated;

  const OnLoadPlaceholder({this.onLoadWidget, required this.webViewIsCreated, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (onLoadWidget == null) return const SizedBox.shrink();

    if (webViewIsCreated) {
      return const SizedBox.shrink();
    } else {
      return onLoadWidget ?? const SizedBox.shrink();
    }
  }
}
