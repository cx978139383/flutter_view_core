// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

/// 用作全局配置
ViewStateRegister viewStateRegister = ViewStateRegister();

/// 页面状态mixin，需要结合Provider使用
///
/// 标识当前页面是否处于忙碌状态
/// 常用于不同状态下显示不同的UI
mixin ViewStateMixin on ChangeNotifier {

  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  ViewStateRegister get register =>
      ViewStateRegister.copyWith(viewStateRegister);

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  /// 改变全局配置的StateView
  setStateView(IStateView stateView) {
    register.register(stateView);
  }

  /// 获取State对应的StateView
  Widget? getStateView(ViewState state) {
    return register.get(state)?.view();
  }

  /// 当前状态对应的页面
  Widget? currentStateView() {
    return register.get(state)?.view();
  }
}

/// 页面状态
/// [ViewState.idle] 空闲默认状态
/// [ViewState.loading] 网络请求状态
/// [ViewState.loaded] 加载完成状态
/// [ViewState.no_result] 无结果状态
/// [ViewState.error] 页面错误状态
/// [ViewState.load_fail] 加载失败状态
///
enum ViewState { idle, loading, loaded, no_result, error, load_fail }

/// 页面状态的抽象类
/// APP需要自行实现并注册到[ViewStateRegister]中去
abstract class IStateView {
  /// 表示当前的状态
  final ViewState state;

  IStateView(this.state);

  /// 返回当前状态下的UI View
  Widget view();
}

/// 全局注册器
///- 设置一个全局 [ViewStateRegister]
///- 调用 [register] 方法设置全局状态处理组件
///- 对于不使用全局状态的页面，可以使用 [ViewStateRegister.copyWith(register)] copy 一份全局[ViewStateRegister], 然后调用[register]方法设置页面指定的状态视图
///
class ViewStateRegister {
  ViewStateRegister();

  ViewStateRegister.copyWith(ViewStateRegister register) {
    map.addAll(register.map);
  }

  Map<ViewState, IStateView> map = {};

  register(IStateView state) {
    map[state.state] = state;
  }

  IStateView? get(ViewState state) {
    return map[state];
  }
}

/// 空闲状态类 IStateView 实现模板
class IdleViewState extends IStateView {
  IdleViewState({ViewState state = ViewState.idle}) : super(state);

  @override
  Widget view() {
    // TODO: implement view
    throw UnimplementedError();
  }
}
