import 'package:flutter_test/flutter_test.dart';
import 'package:themoviesapp/feature/themoviesapp/movie_detail/model/movie_detail_model.dart';
import 'package:themoviesapp/feature/themoviesapp/movie_detail/service/movie_detail_service.dart';
import 'package:themoviesapp/network/network_manager.dart';

void main() {
  test('movies detail service ...', () async {
    IMovieDetailService _service =
        MoviesDetailService(NetworkManager.instance.dio);
    final _results = await _service.getMovieDetail(movieId: 76341);

    expect(_results, isA<MovieDetailModel>());
  });
}
