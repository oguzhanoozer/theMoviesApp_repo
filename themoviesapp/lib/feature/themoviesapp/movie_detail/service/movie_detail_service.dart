import 'dart:io';

import 'package:dio/dio.dart';
import 'package:themoviesapp/core/modules/environment.dart';
import 'package:themoviesapp/feature/themoviesapp/movie_detail/model/movie_detail_model.dart';

import '../../../../network/network_manager.dart';
import '../../../../product/constants/constants.dart';

abstract class IMovieDetailService {
  Future<MovieDetailModel?> getMovieDetail({required int movieId});
}

class MoviesDetailService extends IMovieDetailService {
  Dio dio = NetworkManager.instance.dio;

  @override
  Future<MovieDetailModel?> getMovieDetail({required int movieId}) async {
    var _response = await dio.get("${ServicePath.movie.pathValue}/${movieId}",
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
