import 'package:json_annotation/json_annotation.dart';
part 'movie_list_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MoviesListModel {
  int? page;
  List<Movie>? results;
  @JsonKey(name: 'total_pages')
  int? totalPages;
  @JsonKey(name: 'total_results')
  int? totalResults;

  MoviesListModel(
      {this.page, this.results, this.totalPages, this.totalResults});

  factory MoviesListModel.fromJson(Map<String, dynamic> json) {
    return _$MoviesListModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MoviesListModelToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class Movie {
  /// bool? adult;
  /// String? backdropPath;
  /// List<int>? genreIds;
  int? id;

  /// String? originalLanguage;
  @JsonKey(name: 'original_title')
  String? originalTitle;

  /// String? overview;
  double? popularity;
  @JsonKey(name: 'poster_path')
  String? posterPath;

  /// String? releaseDate;
  String? title;

  /// bool? video;
  @JsonKey(name: 'vote_average')
  double? voteAverage;
  @JsonKey(name: 'vote_count')
  int? voteCount;

  Movie(
      {this.id,
      this.originalTitle,
      this.popularity,
      this.posterPath,
      this.title,
      this.voteAverage,
      this.voteCount});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return _$MovieFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MovieToJson(this);
  }
}
