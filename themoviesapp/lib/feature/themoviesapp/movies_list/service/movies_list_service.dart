import 'dart:io';

import 'package:dio/dio.dart';
import 'package:themoviesapp/core/modules/environment.dart';
import 'package:themoviesapp/network/network_manager.dart';

import '../../../../product/constants/constants.dart';
import '../model/movie_list_model.dart';

abstract class IMoviesListService {
  Future<MoviesListModel?> getMoviesList({required int pageValue});
  Future<MoviesListModel?> getSearchMoviesList(
      {required String textValue, required int pageValue});
}

class MoviesListService extends IMoviesListService {
  Dio dio = NetworkManager.instance.dio;

  @override
  Future<MoviesListModel?> getMoviesList({required int pageValue}) async {
    var _response = await dio.get(ServicePath.discover.pathValue,
        queryParameters: Map.fromEntries([
          QueriesMap.api_key.getMapValue(Environment.apiUrl),
          QueriesMap.page.getMapValue("${pageValue}")
        ]));

    if (_response.statusCode == HttpStatus.ok) {
      final _data = _response.data;
      if (_data is Map<String, dynamic>) {
        var _resultData = MoviesListModel.fromJson(_data);
        return _resultData;
      }
    }
    return null;
  }

  @override
  Future<MoviesListModel?> getSearchMoviesList(
      {String textValue = "", required int pageValue}) async {
    var _response = await dio.get(ServicePath.search.pathValue,
        queryParameters: Map.fromEntries([
          QueriesMap.api_key.getMapValue(Environment.apiUrl),
          QueriesMap.page.getMapValue("${pageValue}"),
          QueriesMap.query.getMapValue(textValue),
        ]));

    if (_response.statusCode == HttpStatus.ok) {
      final _data = _response.data;
      if (_data is Map<String, dynamic>) {
        var _resultData = MoviesListModel.fromJson(_data);
        return _resultData;
      }
    }
    return null;
  }
}
