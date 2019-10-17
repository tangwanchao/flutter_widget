import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget/flutter_widget.dart';

class KeyBoardStateWidgetExample extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: KeyboardStateWidget(
          child: TextField(
            controller: _controller,
          ),
          listener: (keyBoardIsOpen) {
            _controller.text = "keyBoardIsOpen = $keyBoardIsOpen";
          },
        ),
      ),
    );
  }
}
