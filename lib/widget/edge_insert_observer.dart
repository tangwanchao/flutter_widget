import 'package:flutter/material.dart';

mixin BottomInsertObserver<T extends StatefulWidget> on State<T>, WidgetsBindingObserver {
  bool _didChangeMetrics = false;
  WidgetsBinding _widgetsBinding = WidgetsBinding.instance;
  double _preBottomInset = 0;
  double _bottomInset = 0;

  ///  默认值为 false,这种情况下只有当前路由是最顶层路由 [ModalRoute.of(context).isCurrent] 才会调用 [bottomInsertComplete]
  ///  如果为 true 总是调用 [bottomInsertComplete]
  bool alwaysNotify = false;

  @override
  void initState() {
    _widgetsBinding.addObserver(this);
    _widgetsBinding.addPostFrameCallback((Duration timeStamp) {
      _widgetsBinding.addPersistentFrameCallback((Duration timeStamp) {
        if (!alwaysNotify && !ModalRoute
            .of(context)
            .isCurrent) {
          return;
        }

        if (!_didChangeMetrics) {
          return;
        }

        _preBottomInset = _bottomInset;
        _bottomInset = MediaQuery
            .of(context)
            .viewInsets
            .bottom;

        if (_preBottomInset != _bottomInset) {
          WidgetsBinding.instance.scheduleFrame();
          return;
        }

        _didChangeMetrics = false;
        bottomInsertComplete();
      });
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
