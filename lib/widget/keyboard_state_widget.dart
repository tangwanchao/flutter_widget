import 'package:flutter/material.dart';
import 'package:flutter_widget/widget/edge_insert_observer.dart';
import 'package:provider/provider.dart';

/// 键盘是否开启,配合 provider 使用
class KeyboardState extends ChangeNotifier {
  var keyboardIsShow = false;

  keyboardChanged(bool show) {
    keyboardIsShow = show;
    notifyListeners();
  }
}

/// 键盘状态改变监听 Widget
class KeyboardStateWidget extends StatefulWidget {
  KeyboardStateWidget({@required this.child, this.notifyBottomInsert = 100}) : assert(child != null);

  final Widget child;

  /// 应该提醒的底部插入
  final double notifyBottomInsert;

  @override
  _KeyboardStateWidgetState createState() => _KeyboardStateWidgetState();
}

class _KeyboardStateWidgetState extends State<KeyboardStateWidget> with WidgetsBindingObserver, BottomInsertObserver {
  final keyboardState = KeyboardState();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => keyboardState),
      ],
      child: Consumer<KeyboardState>(
        builder: (_, __, child) => child,
        child: widget.child,
      ),
    );
  }

  @override
  void bottomInsertComplete() {
    final bottomInsert = MediaQueryData.fromWindow(WidgetsBinding.instance.window).viewInsets.bottom;
    keyboardState.keyboardChanged(bottomInsert > widget.notifyBottomInsert);
  }
}
