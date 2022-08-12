import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:view_core/page/base/base.dart';
import 'package:view_core/view_model/view_model.dart';

/// 根据[Provider]封装的Widget
/// 继承自[BasePage]
///
/// 提炼重复代码，方便开发、扩展和迁移
abstract class ProviderPage extends StatefulWidget {

  const ProviderPage({Key? key}) : super(key: key);

}

/// 根据[Provider]封装的[State]
///
/// [build]方法中添加[ChangeNotifierProvider.value(value: value)]
///
/// MVVM模式 [V]是本页面的ViewModel
abstract class ProviderPageState<T extends StatefulWidget, V extends ProviderViewModel>
    extends BasePageState<T> {

  /// 页面级的ViewModel
  late V viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = createViewModel();
  }

  /// 创建内容区域, 由具体的子类实现
  Widget createContent(BuildContext context);

  /// 创建ViewModel，由具体的子类去实现
  V createViewModel();

  @override
  void dispose() {
    ///销毁ViewModel防止发生错误
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<V>.value(
      value: viewModel,
      child: Consumer<V>(
        builder: (context, model, snapshot) {
          return createContent(context);
        },),
    );
  }

}
