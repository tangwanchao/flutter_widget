import 'package:flutter/material.dart';
import 'package:flutter_widget/widget/edge_insert_observer.dart';

/// 键盘状态改变监听 Widget
class KeyboardStateWidget extends StatefulWidget {
  KeyboardStateWidget({@required this.child, @required this.listener, this.notifyBottomInsert = 100})
      : assert(child != null),
        assert(listener != null);

  final Widget child;

  /// 底部改变监听 true 键盘弹出
  final ValueChanged<bool> listener;

  /// 应该提醒的底部插入
  final double notifyBottomInsert;

  @override
  _KeyboardStateWidgetState createState() => _KeyboardStateWidgetState();
}

class _KeyboardStateWidgetState extends State<KeyboardStateWidget> with WidgetsBindingObserver, BottomInsertObserver {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void bottomInsertComplete() {
    final bottomInsert = MediaQueryData.fromWindow(WidgetsBinding.instance.window).viewInsets.bottom;
    widget.listener(bottomInsert >= widget.notifyBottomInsert);
  }
}
