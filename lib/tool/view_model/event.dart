import 'dart:async';
import 'package:locator/locator.dart';
import 'package:view_core/event/event.dart';
import 'package:view_core/view_model/view_model.dart';

mixin EventHandler on BaseViewModel {

  final List<StreamSubscription> _composeSubscription = [];

  /// 使用同一个eventBus发送事件
  void fire<T>(T data) {
    eventBus.fire(data);
  }

  /// 订阅一个eventBus事件
  StreamSubscription subscribe<T>(void Function(T data)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    var subscription = eventBus.on<T>().listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);

    _composeSubscription.add(subscription);

    return subscription;
  }

  /// 取消订阅指定的subscription
  void unsubscribe(StreamSubscription subscription) {
    subscription.cancel();

    if (_composeSubscription.contains(subscription)) {
      _composeSubscription.remove(subscription);
    }
  }

  /// 取消当前页面所有的eventBus订阅
  void unsubscribeAll() {
    if (_composeSubscription.isNotEmpty) {
      for (var ele in _composeSubscription) {
        ele.cancel();
      }
      _composeSubscription.clear();
    }
  }

  /// 订阅其他模块的事件
  subscribeNamed(String url, void Function(dynamic data)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    var subscription = (CoreLocator().subscribe(url: url, eventBus: eventBus)as Stream)
        .listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
    _composeSubscription.add(subscription);
    return subscription;
  }

  @override
  void dispose() {
    unsubscribeAll();
    super.dispose();
  }
}