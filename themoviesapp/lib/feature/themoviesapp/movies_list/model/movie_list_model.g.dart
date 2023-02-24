// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviesListModel _$MoviesListModelFromJson(Map<String, dynamic> json) =>
    MoviesListModel(
      page: json['page'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int?,
      totalResults: json['total_results'] as int?,
    );

Map<String, dynamic> _$MoviesListModelToJson(MoviesListModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results?.map((e) => e.toJson()).toList(),
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      id: json['id'] as int?,
      originalTitle: json['original_title'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'] as String?,
      title: json['title'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'original_title': instance.originalTitle,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'title': instance.title,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };
