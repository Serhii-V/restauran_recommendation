import 'package:flutter/material.dart';

class ResponsivePageContainer extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry padding;
  final bool scrollable;

  const ResponsivePageContainer({
    super.key,
    required this.child,
    this.maxWidth = 760.0,
    this.padding = const EdgeInsets.all(24.0),
    this.scrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: scrollable
              ? SingleChildScrollView(
                  child: Padding(padding: padding, child: child),
                )
              : Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}
