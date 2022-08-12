import 'package:flutter/material.dart';
import 'package:view_core/tool/view_model/event.dart';
import 'package:view_core/tool/view_model/navigation.dart';
import 'package:view_core/tool/view_model/view_state.dart';


/// 基准ViewModel, 包含ViewModel的常用功能
abstract class ProviderViewModel extends BaseViewModel with ViewStateMixin, NavigationHandler, EventHandler {

  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;

  ProviderViewModel({required BuildContext context}) : super(context: context);

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

abstract class BaseViewModel with ChangeNotifier {
  final BuildContext context;
  BaseViewModel({required this.context});
}