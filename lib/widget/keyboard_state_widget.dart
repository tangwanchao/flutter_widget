import 'package:flutter/widgets.dart';
import 'package:flutter_widget/widget/edge_insert_observer.dart';
import 'package:provider/provider.dart';

/// 键盘状态改变监听 Widget
/// Provider版本 [KeyboardStateProvider]
class KeyboardStateWidget extends StatefulWidget {
  KeyboardStateWidget({
    Key key,
    @required this.child,
    @required this.listener,
    this.notifyBottomInsert = 100,
    this.alwaysNotify = false,
  })
      : assert(child != null),
        assert(listener != null),
        super(key: key);

  final Widget child;

  /// 底部改变监听
  /// true 键盘弹出
  final ValueChanged<bool> listener;

  /// 应该提醒的底部插入
  final double notifyBottomInsert;

  /// [BottomInsertObserver.alwaysNotify]
  final bool alwaysNotify;

  @override
  _KeyboardStateWidgetState createState() => _KeyboardStateWidgetState();
}

class _KeyboardStateWidgetState extends State<KeyboardStateWidget> with WidgetsBindingObserver, BottomInsertObserver {
  @override
  bool get alwaysNotify => widget.alwaysNotify;

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

/// 键盘弹出或关闭状态
/// 配合 [KeyboardStateProvider] 使用
class KeyboardState with ChangeNotifier {
  KeyboardState({
    this.isOpen = false,
  });

  bool isOpen;

  /// 键盘状态改变调用
  keyboardStateChanged(bool isOpen) {
    if (this.isOpen == isOpen) {
      return;
    }
    this.isOpen = isOpen;
    notifyListeners();
  }
}

/// 键盘状态 Provider
class KeyboardStateProvider extends StatelessWidget {
  KeyboardStateProvider({
    Key key,
    @required this.child,
    this.notifyBottomInsert = 100,
    this.alwaysNotify = true,
  })
      : assert(child != null),
        super(key: key);

  /// [KeyboardStateWidget.child]
  final Widget child;

  /// [KeyboardStateWidget.notifyBottomInsert]
  final double notifyBottomInsert;

  /// [BottomInsertObserver.alwaysNotify]
  final bool alwaysNotify;

  final KeyboardState keyboardState = KeyboardState();

  @override
  Widget build(BuildContext context) {
    return KeyboardStateWidget(
      child: ChangeNotifierProvider.value(
        child: child,
        value: keyboardState,
      ),
      listener: listen,
      notifyBottomInsert: notifyBottomInsert,
      alwaysNotify: alwaysNotify,
    );
  }

  listen(bool keyboardState) {
    this.keyboardState.keyboardStateChanged(keyboardState);
  }
}
