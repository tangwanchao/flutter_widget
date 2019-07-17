library flutter_widget;
import 'package:flutter/material.dart';

/// 参考 AutomaticKeepAliveClientMixin
class KeepAlive extends StatefulWidget{

  KeepAlive({this.child}):assert(child != null);

  final Widget child;

  @override
  KeepAliveState createState() {
    return new KeepAliveState();
  }
}

class KeepAliveState extends State<KeepAlive> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}