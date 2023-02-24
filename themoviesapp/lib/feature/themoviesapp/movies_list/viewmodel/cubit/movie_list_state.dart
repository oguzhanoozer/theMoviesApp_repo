import 'dart:core';
import 'package:equatable/equatable.dart';
import 'package:themoviesapp/feature/themoviesapp/movies_list/model/movie_list_model.dart';

class MovieListState extends Equatable {
  final List<Movie>? movieAllList;
  final List<Movie>? filteredList;
  final bool? isLoading;
  final bool? isLoadingFilter;
  final bool isInitial;
  final bool isError;
  final bool isUpdated;
  final int? pageNumber;
  final int? pageFilterNumber;
  final bool? moviesListFull;
  final bool? filterListFull;

  MovieListState(
      {this.movieAllList,
      this.filteredList,
      this.isLoading,
      this.isLoadingFilter,
      this.isInitial = false,
      this.isUpdated = false,
      this.pageNumber,
      this.isError = false,
      this.moviesListFull,
      this.filterListFull,
      this.pageFilterNumber});

  @override
  List<Object?> get props => [
        movieAllList,
        filteredList,
        isLoading,
        isUpdated,
        isError,
        pageNumber,
        isLoadingFilter,
        pageFilterNumber,
        moviesListFull,
        filterListFull
      ];

  MovieListState copyWith(
      {List<Movie>? movieAllList,
      List<Movie>? filteredList,
      bool? isLoading,
      bool? isLoadingFilter,
      bool? isUpdated,
      int? pageNumber,
      int? pageFilterNumber,
      bool? moviesListFull,
      bool? isError,
      bool? filterListFull}) {
    return MovieListState(
      filterListFull: filterListFull ?? this.filterListFull,
      moviesListFull: moviesListFull ?? this.moviesListFull,
      isLoadingFilter: isLoadingFilter ?? this.isLoadingFilter,
      movieAllList: movieAllList ?? this.movieAllList,
      filteredList: filteredList ?? this.filteredList,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isUpdated: isUpdated ?? this.isUpdated,
      pageNumber: pageNumber ?? this.pageNumber,
      pageFilterNumber: pageFilterNumber ?? this.pageFilterNumber,
    );
  }
}
