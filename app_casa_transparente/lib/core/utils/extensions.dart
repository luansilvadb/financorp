/// Functional extensions to make Dart 3 collection operations more dense and expressive.
extension SumByIterable<T> on Iterable<T> {
  /// Sums a numeric property of elements in an [Iterable].
  /// 
  /// Example:
  /// ```dart
  /// final total = despesas.sumBy((d) => d.valor);
  /// ```
  double sumBy(num Function(T) f) {
    return fold(0.0, (previousValue, element) => previousValue + f(element).toDouble());
  }
}
