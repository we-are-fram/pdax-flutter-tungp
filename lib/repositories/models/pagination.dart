/// {@template pagination}
/// The information of pagination.
/// {@endtemplate}
final class Pagination<T> {
  Pagination({
    required this.total,
    required this.items,
  });

  /// Represent the total item after loading.
  final int total;

  /// Represent the list of corresponding information.
  final List<T> items;
}
