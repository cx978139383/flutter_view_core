import 'package:flutter/material.dart';
import 'package:view_core/tool/view/draw/draw.dart';
import 'package:view_core/tool/view/keyboard/keyboard.dart';

/// 页面基类 用于提供页面级别的常用功能
@immutable
abstract class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);
}

/// State 基类
abstract class BasePageState<T extends StatefulWidget> extends State<T>
    with
        WidgetsBindingObserver,
        KeyboardHandler,
        ViewDrawHandler
{
  /// 执行基础的初始化工作
  ///
  ///  WidgetsBinding.instance?.addPostFrameCallback((timeStamp){} 等待context生成后初始化其他mixin
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /// 此处会按照with后的顺序，从后到前依次调用各mixin的init方法
      onMounted();
    });
    super.initState();
  }

  /// 当前视图element挂载完毕
  onMounted() {}
}
