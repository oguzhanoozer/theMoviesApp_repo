import 'package:flutter/material.dart';

class ApplicationConstants {
  static ApplicationConstants? _instance;
  static ApplicationConstants get instance {
    _instance ??= ApplicationConstants._init();
    return _instance!;
  }

  ApplicationConstants._init();

  final noInternetConnectionText = "No internet connection!";
  final ThemoviedbImageURL = "https://image.tmdb.org/t/p/w300";
  String detailText = "Detail";
  String typeText = "Type";
  String searchMovies = "Search movies...(Min 2 character)";
  String allItemsFetched = "All items fetched";

  Color greyColor = Colors.grey;
  Color blackColor = Colors.black;
  Color whiteColor = Colors.white;
}

enum ServicePath {
  discover('/discover/movie'),
  search('/search/movie'),
  movie('/movie');

  final String pathValue;
  const ServicePath(this.pathValue);

  ///String get withDividerPath => '';
}

enum QueriesMap {
  api_key,
  page,
  query;

  MapEntry<String, String> getMapValue(String value) {
    return MapEntry(name, value);
  }
}

enum ImagePathEnum {
  loadingGif('assets/images/loading_image.gif'),

  notFoundImage('assets/images/no-image-placeholder.png');

  final String pathValue;
  const ImagePathEnum(this.pathValue);
}

extension MovieImagePathExtension on String {
  String get posterImagePath =>
      "${ApplicationConstants.instance.ThemoviedbImageURL}${this}";
}

double kZero = 0;
double kOne = 1;

enum Durations {
  low(Duration(milliseconds: 500)),
  normal(Duration(seconds: 1));

  final Duration value;
  const Durations(this.value);
}
