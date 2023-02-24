import 'package:dio/dio.dart';

class NetworkManager {
  static NetworkManager? _instance;
  static NetworkManager get instance {
    _instance ??= NetworkManager._init();
    return _instance!;
  }

  NetworkManager._init() {
    dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
    ));
  }

  late Dio dio;
  final _baseUrl = "https://api.themoviedb.org/3";
}
