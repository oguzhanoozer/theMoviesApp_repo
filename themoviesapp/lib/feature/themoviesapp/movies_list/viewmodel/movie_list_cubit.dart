import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviesapp/feature/themoviesapp/movies_list/model/movie_list_model.dart';
import 'package:themoviesapp/feature/themoviesapp/movies_list/service/movies_list_service.dart';

class MovieListCubit extends Cubit<MovieListStates> {
  MovieListCubit() : super(MovieListLoading());

  IMoviesListService moviesListService = MoviesListService();

  List<Movie> movieAllList = [];
  late bool hasNextData;
  int _currentPage = 1;

  Future<void> fetchMovieList() async {
    final _movieListResponse =
        await moviesListService.getMoviesList(pageValue: 1);
    hasNextData = _movieListResponse != null &&
            _movieListResponse.page != null &&
            _movieListResponse.totalPages != null &&
            (_movieListResponse.page!) < (_movieListResponse.totalPages!)
        ? true
        : false;

    movieAllList = _movieListResponse?.results ?? [];
    emit(MovieListLoaded(movieAllList, hasNextData));
  }

  Future<void> fetchMoreMovieList() async {
    emit(MovieListMoreLoading());
    final _movieListResponse =
        await moviesListService.getMoviesList(pageValue: _currentPage);
    hasNextData = _movieListResponse != null &&
            _movieListResponse.page != null &&
            _movieListResponse.totalPages != null &&
            (_movieListResponse.page!) < (_movieListResponse.totalPages!)
        ? true
        : false;
    _currentPage++;
    movieAllList.addAll(_movieListResponse?.results ?? []);
    emit(MovieListLoaded(movieAllList, hasNextData));
  }

  Future<void> fetchMoviesByItems(String searchValue) async {
    if (searchValue.isEmpty) {
      emit(MovieListLoaded(movieAllList, hasNextData));
    } else {
      emit(MovieListLoading());
      CancelableOperation<void>? _cancellableOperation;
      _cancellableOperation?.cancel();
      _cancellableOperation = CancelableOperation.fromFuture(
        Future.delayed(Durations.normal.value),
        onCancel: () {
          ErrorsMixin.print("Operations was cancelled");
        },
      );

      List<Movie> _movieList = [];
      await _cancellableOperation.value.then((value) async {
        final _movieSearchListResponse =
            await moviesListService.getSearchMoviesList(
                textValue: searchValue, pageValue: _currentPage);
        _movieList = _movieSearchListResponse?.results ?? [];
      });
      print("search" + _movieList.length.toString());
      emit(MovieListLoaded(_movieList, hasNextData));
    }
  }
}

abstract class MovieListStates {}

class MovieListLoading extends MovieListStates {}

class MovieListSearching extends MovieListStates {}

class MovieListMoreLoading extends MovieListStates {}

class MovieListLoaded extends MovieListStates {
  final List<Movie> movieList;
  final bool hasNextData;

  MovieListLoaded(this.movieList, this.hasNextData);
}

mixin ErrorsMixin {
  static void print(dynamic key) {
    if (!kReleaseMode) return;
    print(key);
  }
}

enum Durations {
  low(Duration(milliseconds: 500)),
  normal(Duration(seconds: 1));

  final Duration value;
  const Durations(this.value);
}
