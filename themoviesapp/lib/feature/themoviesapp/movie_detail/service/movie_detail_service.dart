import 'dart:io';

import 'package:dio/dio.dart';
import 'package:themoviesapp/core/modules/environment.dart';
import 'package:themoviesapp/feature/themoviesapp/movie_detail/model/movie_detail_model.dart';

import '../../../../network/network_manager.dart';
import '../../../../product/constants/application_constants.dart';

abstract class IMovieDetailService {
  IMovieDetailService(this.networkManager);

  Future<MovieDetailModel?> getMovieDetail({required int movieId});
  final Dio networkManager;
}

class MoviesDetailService extends IMovieDetailService {
  MoviesDetailService(super.networkManager);

  @override
  Future<MovieDetailModel?> getMovieDetail({required int movieId}) async {
    var _response =
        await networkManager.get("${ServicePath.movie.pathValue}/${movieId}",
            queryParameters: Map.fromEntries([
              QueriesMap.api_key.getMapValue(Environment.apiUrl),
            ]));

    if (_response.statusCode == HttpStatus.ok) {
      final _data = _response.data;
      if (_data is Map<String, dynamic>) {
        var _resultData = MovieDetailModel.fromJson(_data);
        return _resultData;
      }
    }
    return null;
  }
}
