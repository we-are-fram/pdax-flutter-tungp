import 'package:dio/dio.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';

// coverage:ignore-file
/// The configuration of API client.
final class ApiConfig {
  static const _domain = 'https://fakerapi.it/api/v1';

  /// The instance of API client
  static Dio client = Dio(
    BaseOptions(baseUrl: _domain),
  )..interceptors.addAll([
      PrettyDioLogger(
        showCUrl: true,
        requestHeader: true,
        queryParameters: true,
        canShowLog: true,
      ),
    ]);
}
