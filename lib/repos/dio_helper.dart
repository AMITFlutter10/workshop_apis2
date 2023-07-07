import 'package:dio/dio.dart';
import 'package:workshop_apis2/repos/end_points.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
      ),
    );
  }
}
