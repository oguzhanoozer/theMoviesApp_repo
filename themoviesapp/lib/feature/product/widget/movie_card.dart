import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:themoviesapp/feature/product/widget/vote_card_widget.dart';
import 'package:themoviesapp/feature/themoviesapp/movies_list/model/movie_list_model.dart';
import 'package:themoviesapp/product/constants/application_constants.dart';
import '../../../product/widget/card_widget.dart';
import '../../../product/widget/movie_image_load.dart';
import 'text_widgets.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.movie,
    required BuildContext context,
  }) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return _buildMoviesCardWidget(movie, context);
  }

  Widget _buildMoviesCardWidget(Movie movie, BuildContext context) {
    return CardWidget(
      marginValue: EdgeInsets.all(context.lowValue),
      child: Column(children: [
        Expanded(flex: 3, child: _buildImageStack(movie, context)),
        Expanded(flex: 1, child: _buildTitleWidget(context, movie))
      ]),
    );
  }

  Padding _buildTitleWidget(BuildContext context, Movie movie) {
    return Padding(
        padding: context.paddingLow,
        child: BodySmallText(maxLines: 3, movie.title ?? "", context));
  }

  Stack _buildImageStack(Movie movie, BuildContext context) {
    return Stack(children: [
      MovieImageWidget(imagePath: (movie.posterPath ?? "").posterImagePath),
      Positioned(
          bottom: 10,
          right: 0,
          child:
              VoteCardWidget(context, movie.voteAverage!.toStringAsFixed(1))),
    ]);
  }
}
