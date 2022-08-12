import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:view_core/view_model/view_model.dart';

mixin NavigationHandler on BaseViewModel {

  navigator() {
    return Navigator.of(context);
  }

  bool canPop() {
    return Navigator.of(context).canPop();
  }

  /// 将pageName对应的widget压入当前路由栈的栈顶
  Future<T?> pushNamed<T>(String pageName, {Object? arg}) async {
    return Navigator.pushNamed<T>(context, pageName, arguments: arg);
  }

  /// 替换当前的route
  Future<T?> pushReplacementNamed<T>(String pageName, {Object? arg}) async {
    return Navigator.of(context).pushReplacementNamed(pageName, arguments: arg);
  }

  /// 将路由栈的顶部Widget移除，回退到上一个界面。
  void pop<T extends Object?>([T? result]) {
    if (canPop()) {
      if (null == result) {
        Navigator.pop(context);
      } else {
        Navigator.pop<T>(context, result);
      }
    } else {
      //说明已经没法回退了 ， 可以关闭了
      finishFlutterPageOrApp();
    }
  }

  /// 关闭最后一个 flutter 页面 ， 如果是原生跳过来的则回到原生，否则关闭app
  void finishFlutterPageOrApp() {
    SystemNavigator.pop();
  }
  
}