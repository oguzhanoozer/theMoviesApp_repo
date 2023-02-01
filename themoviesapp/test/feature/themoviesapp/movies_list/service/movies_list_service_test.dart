import 'package:flutter_test/flutter_test.dart';
import 'package:themoviesapp/feature/themoviesapp/movies_list/model/movie_list_model.dart';

import 'package:themoviesapp/feature/themoviesapp/movies_list/service/movies_list_service.dart';

void main() {
  test('movies list service ...', () async {
    IMoviesListService _service = MoviesListService();
    final _results = (await _service.getMoviesList(pageValue: 12))?.results;

    expect(_results, isA<List<Movie>>());
  });
}
