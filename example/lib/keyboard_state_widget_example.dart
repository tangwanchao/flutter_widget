import 'package:flutter/material.dart';
import 'package:flutter_widget/flutter_widget.dart';
import 'package:provider/provider.dart';

class KeyBoardStateWidgetExample extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // KeyboardStateWidget 监听键盘状态
        body: KeyboardStateWidget(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _controller,
              ),
              // 使用 KeyboardStateProvider 提供的键盘状态
              // 这里获取的状态和上面的 KeyboardStateWidget 无关
              Consumer<KeyboardState>(
                builder: (context, value, child) =>
                    Text("键盘是否打开${value.isOpen}"),
              )
            ],
          ),
          // KeyboardStateWidget 的键盘回调
          listener: (keyBoardIsOpen) {
            _controller.text = "keyBoardIsOpen = $keyBoardIsOpen";
          },
        ),
      ),
    );
  }
}
