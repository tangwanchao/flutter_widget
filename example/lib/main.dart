import 'package:flutter/material.dart';
import 'package:flutter_widget/flutter_widget.dart';
import 'keyboard_state_widget_example.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 提供全局键盘状态
    return KeyboardStateProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: KeyBoardStateWidgetExample(),
      ),
    );
  }
}
