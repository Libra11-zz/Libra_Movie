class NetState {}

// loading状态
class NetLoadingState extends NetState {}

// 网络请求错误状态
class NetErrorState extends NetState {}

// 显示loading对话框状态
class NetShowDialogState extends NetState {}

// 隐藏loading对话框状态
class NetHideDialogState extends NetState {}

// 请求到数据的状态
class NetContentState<T> extends NetState {
  T t;

  NetContentState(this.t);
}
