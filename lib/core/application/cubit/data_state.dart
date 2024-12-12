enum Status { initial, loading, success, failure }


class DataState<T> {
  final T? data;
  final Status status;
  final String? error;

  DataState({this.data, this.status = Status.initial, this.error});

  DataState<T> copyWith({T? data, Status? status, String? error}) {
    return DataState(
      data: data ?? this.data,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
