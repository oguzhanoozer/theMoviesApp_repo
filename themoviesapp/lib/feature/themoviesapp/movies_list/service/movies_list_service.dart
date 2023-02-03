import 'dart:io';

import 'package:dio/dio.dart';
import 'package:themoviesapp/core/modules/environment.dart';
import 'package:themoviesapp/network/network_manager.dart';

import '../../../../product/constants/application_constants.dart';
import '../model/movie_list_model.dart';

abstract class IMoviesListService {
  IMoviesListService(this.networkManager);

  Future<MoviesListModel?> getMoviesList({required int pageValue});
  Future<MoviesListModel?> getSearchMoviesList(
      {required String textValue, required int pageValue});

  final Dio networkManager;
}

class MoviesListService extends IMoviesListService {
  MoviesListService(super.networkManager);

  @override
  Future<MoviesListModel?> getMoviesList({required int pageValue}) async {
    var _response = await networkManager.get(ServicePath.discover.pathValue,
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
    var _response = await networkManager.get(ServicePath.search.pathValue,
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
