import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:themoviesapp/core/modules/environment.dart';
import 'package:themoviesapp/feature/themoviesapp/movies_list/model/movie_list_model.dart';
import 'package:themoviesapp/feature/themoviesapp/movies_list/service/movies_list_service.dart';
import 'package:themoviesapp/product/constants/application_constants.dart';

import 'mock_json.dart';
import 'mock_json_searched.dart';
import 'mock_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final _baseUrl = "https://api.themoviedb.org/3";
  late MockDio mockDio;
  late IMoviesListService _service;

  setUp(() async {
    mockDio = MockDio();
    mockDio.options = BaseOptions(baseUrl: _baseUrl);
    _service = MoviesListService(mockDio);
    await dotenv.load(fileName: Environment.fileName);
  });
  test('Mock List Service Test', () async {
    when(mockDio.get(ServicePath.discover.pathValue,
        queryParameters: Map.fromEntries([
          QueriesMap.api_key.getMapValue(Environment.apiUrl),
          QueriesMap.page.getMapValue("1")
        ]))).thenAnswer((_) async {
      return Response(
          data: MockData.listMockJson,
          statusCode: 200,
          requestOptions: RequestOptions(path: ServicePath.discover.pathValue));
    });

    final _results = (await _service.getMoviesList(pageValue: 1))?.results;

    expect(_results, isA<List<Movie>>());
    expect(_results?.length, 2);
  });
  test('Mock List Service Null Test', () async {
    when(mockDio.get(ServicePath.discover.pathValue,
        queryParameters: Map.fromEntries([
          QueriesMap.api_key.getMapValue(Environment.apiUrl),
          QueriesMap.page.getMapValue("1")
        ]))).thenAnswer((_) async {
      return Response(
          data: MockData.listMockJson,
          statusCode: 404,
          requestOptions: RequestOptions(path: ServicePath.discover.pathValue));
    });

    expect(await _service.getMoviesList(pageValue: 1), null);
  });

  test('Mock List Searched Service Test', () async {
    when(mockDio.get(ServicePath.search.pathValue,
        queryParameters: Map.fromEntries([
          QueriesMap.api_key.getMapValue(Environment.apiUrl),
          QueriesMap.page.getMapValue("1"),
          QueriesMap.query.getMapValue("avatar"),
        ]))).thenAnswer((_) async {
      return Response(
          data: MockDataSearched.mocksSearchedJson,
          statusCode: 200,
          requestOptions: RequestOptions(path: ServicePath.search.pathValue));
    });

    final _results =
        (await _service.getSearchMoviesList(pageValue: 1, textValue: "avatar"))
            ?.results;

    expect(_results, isA<List<Movie>>());
    expect(_results?.length, 20);
  });

  test('Mock List Searched Null Service Test', () async {
    when(mockDio.get(ServicePath.search.pathValue,
        queryParameters: Map.fromEntries([
          QueriesMap.api_key.getMapValue(Environment.apiUrl),
          QueriesMap.page.getMapValue("1"),
          QueriesMap.query.getMapValue("avatar"),
        ]))).thenAnswer((_) async {
      return Response(
          data: MockDataSearched.mocksSearchedJson,
          statusCode: 404,
          requestOptions: RequestOptions(path: ServicePath.search.pathValue));
    });

    expect(
        await _service.getSearchMoviesList(pageValue: 1, textValue: "avatar"),
        null);
  });
}
