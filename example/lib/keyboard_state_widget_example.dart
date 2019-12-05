import 'package:flutter/material.dart';
import 'package:flutter_widget/flutter_widget.dart';
import 'package:provider/provider.dart';

class KeyBoardStateWidgetExample extends StatelessWidget {
  final BottomInset _bottomInset = BottomInset();

  @override
  Widget build(BuildContext context) {
    return KeyboardStateProvider(
      child: SafeArea(
        child: Scaffold(
          // KeyboardStateWidget 监听键盘状态
          resizeToAvoidBottomInset: false,
          body: KeyboardStateWidget(
            child: Column(
              children: <Widget>[
                TextField(),
                // 使用 KeyboardStateProvider 提供的键盘状态
                // 这里获取的状态和上面的 KeyboardStateWidget 无关
                Consumer<KeyboardState>(
                  builder: (context, value, child) => Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "全局键盘监听: \n键盘是否打开${value.keyboardIsOpen}\n底部插入:${value.currentBottomInset}",
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ChangeNotifierProvider.value(
                  value: _bottomInset,
                  child: Consumer<BottomInset>(
                    builder: (context, value, child) => Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "局部底部插入监听: \n底部插入:${value.bottomInset}",
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // KeyboardStateWidget 的键盘回调
            listener: _bottomInset.bottomInsetChanged,
          ),
        ),
      ),
    );
  }
}

class BottomInset with ChangeNotifier {
  double _bottomInset = 0;

  get bottomInset => _bottomInset;

  bottomInsetChanged(double bottomInset) {
    if (this._bottomInset == bottomInset) {
      return;
    }
    this._bottomInset = bottomInset;
    notifyListeners();
  }
}
