// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:themoviesapp/feature/themoviesapp/movie_detail/model/movie_detail_model.dart';

import 'package:themoviesapp/feature/themoviesapp/movies_list/model/movie_list_model.dart';

class MovieDetailState extends Equatable {
  final bool? isLoading;
  final bool isError;
  final MovieDetailModel? movie;

  MovieDetailState({this.movie, this.isLoading, this.isError = false});

  @override
  List<Object?> get props => [isLoading, movie, isError];

  MovieDetailState copyWith({
    bool? isLoading,
    bool? isError,
    MovieDetailModel? movie,
  }) {
    return MovieDetailState(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      movie: movie ?? this.movie,
    );
  }
}
