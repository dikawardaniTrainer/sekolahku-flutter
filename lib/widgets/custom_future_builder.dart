import 'package:flutter/material.dart';
import 'package:sekolah_ku/util/logger.dart';

typedef OnShowDataWidget<T> = Widget Function(T data);
typedef OnErrorFuture = Function(Object error, Object stackTrace);

class CustomFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final OnShowDataWidget<T> onShowDataWidget;
  final Widget noDataWidget;
  final Widget loadingWidget;
  final OnErrorFuture? onErrorFuture;

  const CustomFutureBuilder({
    super.key,
    required this.future,
    required this.onShowDataWidget,
    required this.noDataWidget,
    required this.loadingWidget,
    this.onErrorFuture
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
        future: future.catchError((e, s) {
          debugError(e, s);
          onErrorFuture?.call(e, s);
        }),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return loadingWidget;
            case ConnectionState.done:
              final data = snapshot.data;
              if (data != null) {
                return onShowDataWidget.call(data);
              }
          }
          return noDataWidget;
    });
  }
}
