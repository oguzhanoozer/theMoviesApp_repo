import 'package:flutter/material.dart';
import 'package:themoviesapp/feature/themoviesapp/movie_detail/view/movie_detail_view.dart';
import 'package:themoviesapp/product/constants/application_constants.dart';
import '../../feature/themoviesapp/movies_list/view/movie_list_view.dart';

class RouterGen {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case movieListViewRoute:
        return MaterialPageRoute(builder: (_) => const MovieListView());
      case movieDetailViewRoute:
        var data = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => MovieDetailView(movieID: data));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text(
                          '${ApplicationConstants.instance.noRouteDefined} ${settings.name}')),
                ));
    }
  }
}

const String movieListViewRoute = '/';
const String movieDetailViewRoute = '/movieDetail';
