class CacheData<T> {
  CacheData({required T data, required this.staleTime}) : _data = data;

  factory CacheData.fromDuration({required T data, required Duration ttl}) =>
      CacheData(data: data, staleTime: DateTime.now().add(ttl));

  final T _data;
  final DateTime staleTime;

  bool get isStale => DateTime.now().isAfter(staleTime);
  T? get data => isStale ? null : _data;
}
