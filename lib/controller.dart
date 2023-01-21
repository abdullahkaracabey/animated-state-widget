import 'package:animated_state_widget/widget_state.dart';
import 'package:flutter/foundation.dart';

class AnimatedStateController extends ChangeNotifier {
  WidgetState _state = WidgetState.init;
  WidgetState get state => _state;

  AnimatedStateController();

  void start() {
    if (_state != WidgetState.onAction) {
      _state = WidgetState.onAction;
      notifyListeners();
    }
  }

  void done({Duration? revertDuration}) {
    if (_state != WidgetState.completed) {
      _state = WidgetState.completed;
      notifyListeners();

      if (revertDuration != null) {
        Future.delayed(revertDuration, () {
          _state = WidgetState.init;
          notifyListeners();
        });
      }
    }
  }

  void init() {
    if (_state != WidgetState.init) {
      _state = WidgetState.init;
      notifyListeners();
    }
  }

  void error({Duration? revertDuration}) {
    if (_state != WidgetState.error) {
      _state = WidgetState.error;
      notifyListeners();

      if (revertDuration != null) {
        Future.delayed(revertDuration, () {
          _state = WidgetState.init;
          notifyListeners();
        });
      }
    }
  }
}
