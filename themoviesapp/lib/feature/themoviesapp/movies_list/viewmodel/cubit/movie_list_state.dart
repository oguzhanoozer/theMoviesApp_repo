import 'dart:core';
import 'package:equatable/equatable.dart';
import 'package:themoviesapp/feature/themoviesapp/movies_list/model/movie_list_model.dart';

class MovieListState extends Equatable {
  final List<Movie>? movieAllList;
  final List<Movie>? filteredList;
  final bool? isLoading;
  final bool? isLoadingFilter;
  final bool isInitial;
  final bool isUpdated;
  final int? pageNumber;
  final int? pageFilterNumber;

  MovieListState(
      {this.movieAllList,
      this.filteredList,
      this.isLoading,
      this.isLoadingFilter,
      this.isInitial = false,
      this.isUpdated = false,
      this.pageNumber,
      this.pageFilterNumber});

  @override
  List<Object?> get props => [
        movieAllList,
        filteredList,
        isLoading,
        isUpdated,
        pageNumber,
        isLoadingFilter,
        pageFilterNumber
      ];

  MovieListState copyWith({
    List<Movie>? movieAllList,
    List<Movie>? filteredList,
    bool? isLoading,
    bool? isLoadingFilter,
    bool? isUpdated,
    int? pageNumber,
    int? pageFilterNumber,
  }) {
    return MovieListState(
      isLoadingFilter: isLoadingFilter ?? this.isLoadingFilter,
      movieAllList: movieAllList ?? this.movieAllList,
      filteredList: filteredList ?? this.filteredList,
      isLoading: isLoading ?? this.isLoading,
      isUpdated: isUpdated ?? this.isUpdated,
      pageNumber: pageNumber ?? this.pageNumber,
      pageFilterNumber: pageFilterNumber ?? this.pageFilterNumber,
    );
  }
}





// class DetailState {
//   final List<int> numList;
//   final int number;

//   DetailState(this.numList, this.number);

//   DetailState copyWith({
//     List<int>? numList,
//     int? number,
//   }) {
//     return DetailState(
//       numList ?? this.numList,
//       number ?? this.number,
//     );
//   }

//   @override
//   String toString() => 'DetailState(numList: $numList, number: $number)';

//   @override
//   bool operator ==(covariant DetailState other) {
//     if (identical(this, other)) return true;

//     return listEquals(other.numList, numList) && other.number == number;
//   }

//   @override
//   int get hashCode => numList.hashCode ^ number.hashCode;
// }

// void main(List<String> args) {
//   DetailState detailState = DetailState([1, 2, 3, 4, 5], 90);
//   final _data = detailState.copyWith(number: 10);
//   print(detailState.toString());
//   print(_data.toString());
//   print(detailState == _data);
// }
