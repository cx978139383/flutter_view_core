
# 页面布局的基本功能

- 基准页面能力
- EventBus管理

# EventBus  [event]
```dart
final EventBus eventBus = EventBus();
```
定义了全局eventBus，所有页面对于事件的分发和订阅应该使用此对象

# 页面布局基础功能封装  [page]

## BasePage

页面开发的基准类，原则上所有页面应该继承自本类，他的主要作用是混入了多个mixin包括：

- [PageMixinBase] 提供BuildContext管理和每个mixin中或许需要实现的onDestroy方法
- [PageEventBusActionMixin] 提供在State中直接操作全局eventBus的能力，包括事件订阅、取消订阅、事件分发、取消当前State所有的订阅等
- [PageGeneralActionMixin] 通用功能， 包括日志输出、toast等，可后续不断添加
- [PageNavigationActionMixin] 导航和路由功能
- [PageUIToolsMixin] 常用的屏幕参数、hex颜色使用、rpx适配、黑暗模式判断、横竖屏等

## 基于Provider的MVVM使用的页面基类  [ProviderPage]
此类继承自[BasePage], 含有上述所有mixin的功能

需要实现两个方法
```dart
  /// 创建内容区域, 由具体的子类实现
  Widget createContent(BuildContext context);
  
  /// 创建ViewModel，由具体的子类去实现
  V createViewModel();
```

### 页面状态管理  [ViewStateMixin]

提供页面状态切换和为不同的状态注册视图的功能