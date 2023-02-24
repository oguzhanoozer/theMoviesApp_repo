import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:themoviesapp/core/modules/environment.dart';
import 'package:themoviesapp/feature/themoviesapp/movie_detail/model/movie_detail_model.dart';
import 'package:themoviesapp/feature/themoviesapp/movie_detail/service/movie_detail_service.dart';
import 'package:themoviesapp/feature/themoviesapp/movies_list/model/movie_list_model.dart';
import 'package:themoviesapp/product/constants/application_constants.dart';

import 'mock_json.dart';
import 'mock_detail_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final _baseUrl = "https://api.themoviedb.org/3";
  late MockDio mockDio;
  late IMovieDetailService _service;

  setUp(() async {
    mockDio = MockDio();
    mockDio.options = BaseOptions(baseUrl: _baseUrl);
    _service = MoviesDetailService(mockDio);
    await dotenv.load(fileName: Environment.fileName);
  });
  test('Mock Detail Service Test', () async {
    when(mockDio.get("${ServicePath.movie.pathValue}/${99}",
        queryParameters: Map.fromEntries([
          QueriesMap.api_key.getMapValue(Environment.apiUrl),
        ]))).thenAnswer((_) async {
      return Response(
          data: MockData.UserMockJson,
          statusCode: 200,
          requestOptions: RequestOptions(path: ServicePath.movie.pathValue));
    });

    final _results = (await _service.getMovieDetail(movieId: 99));

    expect(_results, isA<MovieDetailModel>());
  });
  test('Mock Detail Null Service Test', () async {
    when(mockDio.get("${ServicePath.movie.pathValue}/${99}",
        queryParameters: Map.fromEntries([
          QueriesMap.api_key.getMapValue(Environment.apiUrl),
        ]))).thenAnswer((_) async {
      return Response(
          data: MockData.UserMockJson,
          statusCode: 404,
          requestOptions: RequestOptions(path: ServicePath.movie.pathValue));
    });

    final _results = (await _service.getMovieDetail(movieId: 0));

    expect(_results, null);
  });
}
