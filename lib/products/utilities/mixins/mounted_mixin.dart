import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

mixin MountedMixin<T extends StatefulWidget> on State<T> {
  Future<void> safeOperation(AsyncCallback callback) async {
    if (!mounted) return;
    await callback.call();
  }
}
