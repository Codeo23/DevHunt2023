enum LoadingStatus {initial, loading, success, error}

extension LoadingStatusExtension on LoadingStatus {
  bool get isInitial => this == LoadingStatus.initial;
  bool get isLoading => this == LoadingStatus.loading;
  bool get isSuccess => this == LoadingStatus.success;
  bool get isError => this == LoadingStatus.error;
}