/// {@template pagination_model}
/// The model that is used to deserialize the response of Pagination.
/// {@endtemplate}
final class PaginationModel<T> {
  /// {@macro pagination_model}
  PaginationModel({
    required this.total,
    required this.data,
  });

  /// Convert the Map<String, dynamic> to an instance of [PaginationModel].
  factory PaginationModel.fromJson({
    required Map<String, dynamic> json,
    required T Function(dynamic json) toModel,
  }) =>
      PaginationModel(
        total: json['total'] as int,
        data: (json['data'] as List<dynamic>).map(toModel).toList(),
      );

  /// Represent the total item which have been loaded.
  final int total;

  /// Represent the list of corresponding data.
  final List<T> data;
}
