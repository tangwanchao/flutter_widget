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
    this.alwaysNotify = false,
  })  : assert(child != null),
        assert(listener != null),
        super(key: key);

  final Widget child;

  /// 底部改变监听
  /// double 底部插入高度
  final ValueChanged<double> listener;

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
    widget.listener(mediaQueryBottomInset());
  }
}

/// 键盘弹出或关闭状态
/// 配合 [KeyboardStateProvider] 使用
class KeyboardState with ChangeNotifier {
  KeyboardState({
    this.keyboardIsOpen = false,
    this.currentBottomInset = 0,
    this.notifyKeyboardStateChangedInsert = 100,
  })  : assert(keyboardIsOpen != null),
        assert(currentBottomInset >= 0),
        assert(notifyKeyboardStateChangedInsert > 0);

  /// 键盘是否打开
  bool keyboardIsOpen;

  /// 当前底部插入
  double currentBottomInset;

  /// 底部插入临界值,当底部插入 >= 该值时认为键盘打开
  double notifyKeyboardStateChangedInsert;

  /// 键盘状态改变调用
  keyboardStateChanged(double bottomInsert) {
    ArgumentError.checkNotNull(bottomInsert, "bottomInsert");
    if (this.currentBottomInset == bottomInsert) {
      return;
    }
    this.currentBottomInset = bottomInsert;
    this.keyboardIsOpen = this.currentBottomInset >= notifyKeyboardStateChangedInsert;
    notifyListeners();
  }
}

/// 键盘状态 Provider
class KeyboardStateProvider extends StatelessWidget {
  KeyboardStateProvider({
    Key key,
    @required this.child,
    this.alwaysNotify = false,
    KeyboardState keyboardState,
  })  : assert(child != null),
        this.keyboardState = keyboardState ?? KeyboardState(),
        super(key: key);

  /// [KeyboardStateWidget.child]
  final Widget child;

  /// [BottomInsertObserver.alwaysNotify]
  final bool alwaysNotify;

  final KeyboardState keyboardState;

  @override
  Widget build(BuildContext context) {
    return KeyboardStateWidget(
      child: ChangeNotifierProvider.value(
        child: child,
        value: keyboardState,
      ),
      listener: listen,
      alwaysNotify: alwaysNotify,
    );
  }

  listen(double bottomInsert) {
    this.keyboardState.keyboardStateChanged(bottomInsert);
  }
}
