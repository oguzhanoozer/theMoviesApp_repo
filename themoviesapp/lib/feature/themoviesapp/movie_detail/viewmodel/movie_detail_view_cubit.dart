import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviesapp/feature/themoviesapp/movie_detail/model/movie_detail_model.dart';
import 'package:themoviesapp/feature/themoviesapp/movie_detail/service/movie_detail_service.dart';
import 'package:themoviesapp/feature/themoviesapp/movies_list/model/movie_list_model.dart';
import 'package:themoviesapp/feature/themoviesapp/movies_list/service/movies_list_service.dart';

class MovieDetailViewCubit extends Cubit<MovieDetailStates> {
  MovieDetailViewCubit() : super(MovieDetailLoading());

  IMovieDetailService moviesDetailService = MoviesDetailService();

  MovieDetailModel? movieDetail;

  Future<void> fetchMovieDetail({required int movieId}) async {
    movieDetail = await moviesDetailService.getMovieDetail(movieId: movieId);
    emit(MovieDetailLoaded(movieDetail!));
  }
}

abstract class MovieDetailStates {}

class MovieDetailLoading extends MovieDetailStates {}

class MovieDetailLoaded extends MovieDetailStates {
  final MovieDetailModel? movie;

  MovieDetailLoaded(this.movie);
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
