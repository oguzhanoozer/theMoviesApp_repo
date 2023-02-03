import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:themoviesapp/feature/themoviesapp/movies_list/service/movies_list_service.dart';
import '../../../../../product/constants/application_constants.dart';
import '../../model/movie_list_model.dart';
import 'movie_list_state.dart';
import 'package:kartal/kartal.dart';

class MovieListCubit extends Cubit<MovieListState> {
  MovieListCubit(this.moviesListService) : super(MovieListState()) {
    initialComplete();
  }
  final IMoviesListService moviesListService;

  String searchOldValue = "";

  Future<void> initialComplete() async {
    await Future.microtask(() {
      emit(MovieListState(isInitial: true));
    });

    await Future.wait([fetchMovieList()]);
    emit(state.copyWith(filteredList: state.movieAllList));
  }

  Future<void> fetchMovieList() async {
    _changeLoading();
    final _movieListResponse =
        await moviesListService.getMoviesList(pageValue: kOne.toInt());
    emit(state.copyWith(movieAllList: _movieListResponse?.results ?? []));
    _changeLoading();
  }

  Future<void> fetchMoreDataList({String value = ""}) async {
    if (state.isUpdated) {
      if (value.isNotEmpty) {
        await fetchNewFilterMoviesByItems(value);
      }
    } else {
      await fetchNewMovies();
    }
  }

  Future<void> fetchNewMovies() async {
    if (state.isLoading ?? false) {
      return;
    }
    _changeLoading();

    int pageNumber = (state.pageNumber ?? kOne.toInt());

    final movieListResponse =
        await moviesListService.getMoviesList(pageValue: ++pageNumber);

    final movieList = movieListResponse?.results ?? [];
    if (movieList.isNotEmpty || state.movieAllList.isNotNullOrEmpty) {
      List<Movie> resultList = [];
      state.movieAllList!.addAll(movieList);
      resultList = state.movieAllList!;

      emit(state.copyWith(
          movieAllList: resultList,
          filteredList: resultList,
          pageNumber: movieListResponse?.page));
    }
    _changeLoading();
  }

  Future<void> fetchMoviesByItems(String searchValue) async {
    if (searchValue.isEmpty || searchOldValue == searchValue) {
      return;
    } else {
      //   _changeLoading();
      searchOldValue = searchValue;
      emit(state.copyWith(
          pageFilterNumber: kOne.toInt(), filteredList: state.movieAllList));

      late MoviesListModel? movieSearchListResponse;
      List<Movie> resultList = [];
      CancelableOperation<void>? cancellableOperation;
      cancellableOperation?.cancel();
      cancellableOperation = CancelableOperation.fromFuture(
        Future.delayed(Durations.normal.value),
        onCancel: () {
          ErrorsMixin.print("Operations was cancelled");
        },
      );

      await cancellableOperation.value.then((value) async {
        movieSearchListResponse = await moviesListService.getSearchMoviesList(
            textValue: searchOldValue, pageValue: kOne.toInt());

        resultList = movieSearchListResponse?.results ?? [];
      });

      emit(state.copyWith(
        isUpdated: true,
        filteredList: resultList,
      ));
      //  _changeLoading();
    }
  }

  Future<void> fetchNewFilterMoviesByItems(String searchValue) async {
    if (searchValue.isEmpty && (state.isLoading ?? false)) {
      return;
    } else {
      print("searchOldValue" + searchOldValue);
      print("searchValue" + searchValue);
      // if (searchOldValue != searchValue) {
      //   emit(state.copyWith(
      //     filteredList: [],
      //     pageFilterNumber: null,
      //   ));
      // }

      _changeLoading();

      int pageNumber = (state.pageFilterNumber ?? kOne.toInt());
      pageNumber++;
      int aaa = pageNumber;
      print("aaa" + aaa.toString());

      final movieListResponse = await moviesListService.getSearchMoviesList(
          textValue: searchValue, pageValue: pageNumber);

      final movieList = movieListResponse?.results ?? [];

      if (movieList.isNotNullOrEmpty) {
        print("aaa");

        List<Movie> currentList = [];
        currentList = state.filteredList!;

        currentList.addAll(movieList);

        int x = movieListResponse?.page ?? 0;
        print("xxx" + x.toString());

        emit(state.copyWith(
            filteredList: currentList,
            pageFilterNumber: movieListResponse?.page));
      }
      _changeLoading();
    }
  }

  void changeIsUpdate() {
    emit(state.copyWith(isUpdated: !(state.isUpdated)));
    emit(state.copyWith(filteredList: state.movieAllList));
  }

  void _changeLoading() {
    emit(state.copyWith(isLoading: !(state.isLoading ?? false)));
  }

  void _changeFilterLoading() {
    emit(state.copyWith(isLoadingFilter: !(state.isLoadingFilter ?? false)));
  }
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
