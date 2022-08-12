
// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:flutter/cupertino.dart';

mixin ViewDrawHandler<T extends StatefulWidget> on State<T> {

  /// 屏幕宽度
  double get screen_width => MediaQuery.of(context).size.width;
  /// 屏幕高度
  double get screen_height => MediaQuery.of(context).size.height;
  /// 状态栏高度
  double get status_bar_height => MediaQuery.of(context).padding.top;
  /// 底部操作栏嵌入的高度
  double get bottom_bar_height => MediaQuery.of(context).padding.bottom;
  /// 屏幕像素密度
  double get dpr => MediaQuery.of(context).devicePixelRatio;
  /// 屏幕方向
  Orientation get orientation => MediaQuery.of(context).orientation;


  /// rpx适配方案
  num rpx(num v) {
    return v.rpx;
  }

  /// 输入String返回Color对象
  Color hex(String hex) {
    return hex.color;
  }

  /// 判断当前是否是竖屏
  bool isScreenPortrait() {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  /// 设备当前是否处于暗黑模式
  isDarkMode() {
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }
}

extension RPX on num {

  num get rpx {
    return this * _scale;
  }

}

/*
* hex格式字符串转颜色
* */
extension HexColor on String {

  //hex 输出 hex格式的颜色
  Color get color {
    String hex = replaceAll("#", "");
    if (hex.length == 6) {
      hex = "FF" + hex;
    }
    if (hex.length == 8) {
      return Color(int.parse("0x$hex"));
    }
    throw Exception('颜色格式错误...请检查输入 $this');
  }

}

double _scale = 1.0;

/// 此函数应该在app启动时调用一次
/// 指定设计图的宽度
/// 供RPX适配方案使用
setMaxWidthForDesign({required dw}) {
  _scale = MediaQueryData.fromWindow(window).size.width / dw;
}