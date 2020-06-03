import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final T model;
  final Widget child;
  final Widget Function(BuildContext context, T value, Widget child) builder;

  ProviderWidget({this.model, this.child, this.builder});

  @override
  _ProviderWidgetState<T> createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => widget.model,
        child: Consumer(builder: widget.builder, child: widget.child));
  }
}
