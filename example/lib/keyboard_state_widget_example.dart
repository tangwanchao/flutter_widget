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
          child: Column(
            children: <Widget>[
              TextField(
                controller: _controller,
              ),
              RaisedButton(
                child: Text("新页面"), onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return KeyBoardStateWidgetExample();
                }));
              },
              ),
            ],
          ),
          listener: (keyBoardIsOpen) {
            _controller.text = "keyBoardIsOpen = $keyBoardIsOpen";
          },
        ),
      ),
    );
  }
}
