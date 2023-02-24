import 'package:json_annotation/json_annotation.dart';
part 'movie_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MovieDetailModel {
  /// bool? adult;
  /// String? backdropPath;
  /// BelongsToCollection? belongsToCollection;
  /// int? budget;
  List<Genres>? genres;

  /// String? homepage;
  int? id;

  /// String? imdbId;
  /// String? originalLanguage;
  @JsonKey(name: 'original_title')
  String? originalTitle;
  String? overview;
  double? popularity;
  @JsonKey(name: 'poster_path')
  String? posterPath;

  /// List<ProductionCompanies>? productionCompanies;
  /// List<ProductionCountries>? productionCountries;
  /// String? releaseDate;
  /// int? revenue;
  /// int? runtime;
  /// List<SpokenLanguages>? spokenLanguages;
  /// String? status;
  /// String? tagline;

  String? title;

  /// bool? video;
  @JsonKey(name: 'vote_average')
  double? voteAverage;
  @JsonKey(name: 'vote_count')
  int? voteCount;

  MovieDetailModel(
      {this.genres,
      this.id,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.title,
      this.voteAverage,
      this.voteCount});

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return _$MovieDetailModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MovieDetailModelToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class Genres {
  int? id;
  String? name;

  Genres({this.id, this.name});

  factory Genres.fromJson(Map<String, dynamic> json) {
    return _$GenresFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GenresToJson(this);
  }
}
