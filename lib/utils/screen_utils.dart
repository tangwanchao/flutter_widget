import 'package:flutter/widgets.dart';
import 'package:flutter_widget/utils/error_utils.dart';

class ScreenUtil {
  ScreenUtil._();

  ///  初始化工具类
  ///  [width] 设计图宽度
  ///  [height] 设计图高度
  ///  请保证获取适配传入参数单位和 [width],[height] 设置单位一致
  ///  [allowFontScaling] 是否允许字体缩放,默认 false
  static void init(
    BuildContext context,
    double width,
    double height, {
    bool allowFontScaling = false,
  }) {
    ArgumentError.checkNotNull(context, "context");
    checkIsPositive(width);
    checkIsPositive(height);

    if (_isInit) {
      return;
    }
    _isInit = true;

    final mediaQueryData = MediaQuery.of(context);
    _scaleWidth = mediaQueryData.size.width / width;
    _scaleHeight = mediaQueryData.size.height / height;
  }

  /// 是否完成初始化
  static bool _isInit = false;

  /// 缩放宽度
  static double _scaleWidth;

  /// 缩放高度
  static double _scaleHeight;
}

_checkInit() {
  if (!ScreenUtil._isInit) {
    throw AssertionError();
  }
}

/// 宽度适配
double adaptW(double designWidth) {
  _checkInit();
  return designWidth * ScreenUtil._scaleWidth;
}

/// 高度适配
double adaptH(double designHeight) {
  _checkInit();
  return designHeight * ScreenUtil._scaleHeight;
}

/// 字体适配
double adaptFont(double font) {
  _checkInit();
  return font * ScreenUtil._scaleWidth;
}
