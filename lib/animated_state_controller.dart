import 'package:flutter/foundation.dart';

enum WidgetState { init, onAction, completed, error }

class AnimatedStateController extends ChangeNotifier {
  WidgetState state = WidgetState.init;

  AnimatedStateController();

  void start() {
    if (state != WidgetState.onAction) {
      state = WidgetState.onAction;
      notifyListeners();
    }
  }

  void done() {
    if (state != WidgetState.completed) {
      state = WidgetState.completed;
      notifyListeners();
    }
  }

  void init() {
    if (state != WidgetState.init) {
      state = WidgetState.init;
      notifyListeners();
    }
  }

  void error() {
    if (state != WidgetState.error) {
      state = WidgetState.error;
      notifyListeners();
    }
  }
}
