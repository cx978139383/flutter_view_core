
import 'package:flutter/material.dart';

mixin KeyboardHandler<T extends StatefulWidget> on State<T>, WidgetsBindingObserver {

  bool _isKeyboardShow = false;
  bool get isKeyboardShow => _isKeyboardShow;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  /// 收起键盘
  hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      try {
        if (MediaQuery.of(context).viewInsets.bottom == 0.0) {
          _isKeyboardShow = false;
        } else {
          _isKeyboardShow = true;
        }
      } catch(e) {
        debugPrint('$e');
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Widget hideTheKeyboardByClickOnTheBlankArea({required Widget child}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        hideKeyboard();
      },
      child: child,
    );
  }
}

