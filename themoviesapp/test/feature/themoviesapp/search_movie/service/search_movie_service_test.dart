import 'package:flutter_test/flutter_test.dart';
import 'package:themoviesapp/feature/themoviesapp/movies_list/model/movie_list_model.dart';
import 'package:themoviesapp/feature/themoviesapp/movies_list/service/movies_list_service.dart';
import 'package:themoviesapp/network/network_manager.dart';

void main() {
  test('movies search service ...', () async {
    IMoviesListService _service =
        MoviesListService(NetworkManager.instance.dio);
    final _results =
        await _service.getSearchMoviesList(textValue: "aa", pageValue: 1);

    expect(_results, isA<List<Movie>>());
  });
}
