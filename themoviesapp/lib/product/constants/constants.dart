class ApplicationConstants {
  static final noInternetConnectionText = "No internet connection!";
  static final ThemoviedbImageURL = "https://image.tmdb.org/t/p/w300";
  static String detailText = "Detail";
  static String typeText = "Type";
  static String searchMovies = "Search movies...";
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
  loadingGif('assets/images/loading.gif'),
  notFoundImage('assets/images/not_found.png');

  final String pathValue;
  const ImagePathEnum(this.pathValue);
}

extension MovieImagePathExtension on String {
  String get posterImagePath =>
      "${ApplicationConstants.ThemoviedbImageURL}${this}";
}
