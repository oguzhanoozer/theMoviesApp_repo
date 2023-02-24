import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:themoviesapp/core/modules/environment.dart';
import 'package:themoviesapp/feature/themoviesapp/movies_list/model/movie_list_model.dart';

import 'package:themoviesapp/feature/themoviesapp/movies_list/service/movies_list_service.dart';
import 'package:themoviesapp/network/network_manager.dart';

void main() {
  test('movies list service ...', () async {
    await dotenv.load(fileName: Environment.fileName);

    IMoviesListService _service =
        MoviesListService(NetworkManager.instance.dio);

    final _results = (await _service.getMoviesList(pageValue: 12))?.results;

    expect(_results, isA<List<Movie>>());
  });
}
