import 'package:animated_state_widget/widget_state.dart';
import 'package:flutter/foundation.dart';

class AnimatedStateController extends ChangeNotifier {
  AnimatedWidgetState _state = AnimatedWidgetState.init;
  AnimatedWidgetState get state => _state;

  AnimatedStateController();

  void start() {
    if (_state != AnimatedWidgetState.onAction) {
      _state = AnimatedWidgetState.onAction;
      notifyListeners();
    }
  }

  void done({Duration? revertDuration}) {
    if (_state != AnimatedWidgetState.completed) {
      _state = AnimatedWidgetState.completed;
      notifyListeners();

      if (revertDuration != null) {
        Future.delayed(revertDuration, () {
          _state = AnimatedWidgetState.init;
          notifyListeners();
        });
      }
    }
  }

  void init() {
    if (_state != AnimatedWidgetState.init) {
      _state = AnimatedWidgetState.init;
      notifyListeners();
    }
  }

  void error({Duration? revertDuration}) {
    if (_state != AnimatedWidgetState.error) {
      _state = AnimatedWidgetState.error;
      notifyListeners();

      if (revertDuration != null) {
        Future.delayed(revertDuration, () {
          _state = AnimatedWidgetState.init;
          notifyListeners();
        });
      }
    }
  }
}
