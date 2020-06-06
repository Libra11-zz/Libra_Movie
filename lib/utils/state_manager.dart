import 'dart:async';
import 'package:libra_movie/utils/net_state.dart';

class StateManager {
  StreamController<NetState> streamController;

  StateManager() {
    streamController = StreamController();
  }

  void dispose() {
    if (streamController != null) {
      streamController.close();
    }
  }

  void loading() {
    streamController.sink.add(LoadingState());
  }

  void error() {
    streamController.sink.add(ErrorState());
  }

  void content<T>(T t) {
    streamController.sink.add(ContentState<T>(t));
  }
}
