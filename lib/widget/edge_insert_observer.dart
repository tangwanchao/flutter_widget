import 'package:flutter/material.dart';

mixin BottomInsertObserver<T extends StatefulWidget>
    on State<T>, WidgetsBindingObserver {
  bool _didChangeMetrics = false;
  WidgetsBinding _widgetsBinding = WidgetsBinding.instance;
  double _preBottomInset = 0;
  double _bottomInset = 0;

  @override
  void initState() {
    _widgetsBinding.addObserver(this);
    _widgetsBinding.addPersistentFrameCallback((Duration timeStamp) {
      if (!_didChangeMetrics) {
        return;
      }

      _preBottomInset = _bottomInset;
      _bottomInset = MediaQuery.of(context).viewInsets.bottom;

      if (_preBottomInset != _bottomInset) {
        WidgetsBinding.instance.scheduleFrame();
        return;
      }

      _didChangeMetrics = false;
      bottomInsertComplete();
    });
    super.initState();
  }

  @override
  void didChangeMetrics() {
    _didChangeMetrics = true;
    super.didChangeMetrics();
  }

  void bottomInsertComplete();

  @override
  void dispose() {
    _widgetsBinding.removeObserver(this);
    super.dispose();
  }
}
