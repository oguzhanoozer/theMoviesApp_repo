// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:themoviesapp/feature/themoviesapp/movie_detail/model/movie_detail_model.dart';

import 'package:themoviesapp/feature/themoviesapp/movies_list/model/movie_list_model.dart';

class MovieDetailState extends Equatable {
  final bool? isLoading;
  final MovieDetailModel? movie;

  MovieDetailState({this.movie, this.isLoading});

  @override
  List<Object?> get props => [isLoading, movie];

  MovieDetailState copyWith({
    bool? isLoading,
    MovieDetailModel? movie,
  }) {
    return MovieDetailState(
      isLoading: isLoading ?? this.isLoading,
      movie: movie ?? this.movie,
    );
  }
}
