import 'package:flutter/material.dart';

class ScreenUtil {
  ScreenUtil._();

  ///  初始化
  ///  默认设计图大小(width = 360dp,height = 640dp)
  ///  所有成员数据均为竖屏下数据(就算横屏初始化宽高也为竖屏数据)
  static void init({
    double width = 360,
    double height = 640,
    double,
    bool allowFontScaling = false,
  }) {
    _width = width;
    _height = height;
    _allowFontScaling = allowFontScaling;
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    final orientation = mediaQuery.orientation;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = orientation == Orientation.portrait ? mediaQuery.size.width : mediaQuery.size.height;
    _screenHeight = orientation == Orientation.portrait ? mediaQuery.size.height : mediaQuery.size.width;
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  /// 设计图尺寸宽度 单位:dp
  static double _width;

  /// 设计图尺寸宽度 单位:dp
  static double _height;

  ///  是否允许字体缩放
  static bool _allowFontScaling;

  /// 屏幕宽度 单位:dp
  static double _screenWidth;

  /// 屏幕高度 单位:dp
  static double _screenHeight;

  /// 屏幕密度
  static double _pixelRatio;

  /// 文本缩放
  static double _textScaleFactor;

  /// 设计图宽度
  static double get width => _width;

  /// 设计图高度
  static double get height => _height;

  /// 是否允许字体缩放
  static bool get allowFontScaling => _allowFontScaling;

  /// 竖屏下屏幕宽度
  static double get screenWidthDp => _screenWidth;

  /// 竖屏下屏幕高度
  static double get screenHeightDp => _screenHeight;

  ///  每个逻辑像素的设备像素数
  static double get pixelRatio => _pixelRatio;

  /// 字体缩放
  static double get textScaleFactor => _textScaleFactor;
}

double width(double width) => width * ScreenUtil.screenWidthDp / ScreenUtil.width;

double height(double height) => height * ScreenUtil.screenHeightDp / ScreenUtil.height;

double sp(double fontSize) =>
    ScreenUtil.allowFontScaling ? width(fontSize) : width(fontSize) / ScreenUtil.textScaleFactor;

double get viewInsertLeft => MediaQueryData.fromWindow(WidgetsBinding.instance.window).viewInsets.left;

double get viewInsertTop => MediaQueryData.fromWindow(WidgetsBinding.instance.window).viewInsets.top;

double get viewInsertRight => MediaQueryData.fromWindow(WidgetsBinding.instance.window).viewInsets.right;

double get viewInsertBottom => MediaQueryData.fromWindow(WidgetsBinding.instance.window).viewInsets.bottom;

double get systemGestureInsetsLeft =>
    MediaQueryData.fromWindow(WidgetsBinding.instance.window).systemGestureInsets.left;

double get systemGestureInsetsTop => MediaQueryData.fromWindow(WidgetsBinding.instance.window).systemGestureInsets.top;

double get systemGestureInsetsRight =>
    MediaQueryData.fromWindow(WidgetsBinding.instance.window).systemGestureInsets.right;

double get systemGestureInsetsBottom =>
    MediaQueryData.fromWindow(WidgetsBinding.instance.window).systemGestureInsets.bottom;

double get paddingLeft => MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.left;

double get paddingTop => MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top;

double get paddingRight => MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.right;

double get paddingBottom => MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.bottom;

double get viewPaddingLeft => MediaQueryData.fromWindow(WidgetsBinding.instance.window).viewPadding.left;

double get viewPaddingTop => MediaQueryData.fromWindow(WidgetsBinding.instance.window).viewPadding.top;

double get viewPaddingRight => MediaQueryData.fromWindow(WidgetsBinding.instance.window).viewPadding.right;

double get viewPaddingBottom => MediaQueryData.fromWindow(WidgetsBinding.instance.window).viewPadding.bottom;
