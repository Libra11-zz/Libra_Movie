class NetState {}

class LoadingState extends NetState {}

class ErrorState extends NetState {}

class ContentState<T> extends NetState {
  T t;
  ContentState(this.t);
}
