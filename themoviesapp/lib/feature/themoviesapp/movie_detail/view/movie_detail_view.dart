import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:themoviesapp/feature/themoviesapp/movie_detail/model/movie_detail_model.dart';
import 'package:themoviesapp/feature/themoviesapp/movie_detail/service/movie_detail_service.dart';
import 'package:themoviesapp/product/mixin/mixin_utility.dart';

import '../../../../network/network_manager.dart';
import '../../../../product/constants/application_constants.dart';
import '../../../../product/widget/card_widget.dart';
import '../../../../product/widget/empty_sizedbox_shrink.dart';
import '../../../../product/widget/movie_image_load.dart';
import '../../../product/widget/text_widgets.dart';
import '../../../product/widget/vote_card_widget.dart';
import '../viewmodel/cubit/movie_detail_cubit.dart';
import '../viewmodel/cubit/movie_detail_state.dart';

class MovieDetailView extends StatefulWidget {
  final int movieID;

  const MovieDetailView({Key? key, required this.movieID}) : super(key: key);
  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView>
    with SnackBarWidgetMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieDetailCubit>(
      create: (context) =>
          MovieDetailCubit(MoviesDetailService(NetworkManager.instance.dio))
            ..fetchMovieDetail(movieId: widget.movieID),
      child: BlocConsumer<MovieDetailCubit, MovieDetailState>(
        listener: (context, state) {
          if (state.isError) {
            buildSnackBar();
          }
        },
        builder: (context, state) {
          return state.isLoading ?? false
              ? const Center(child: CircularProgressIndicator())
              : _buildScaffoldWidget(state.movie, context);
        },
      ),
    );
  }

  Scaffold _buildScaffoldWidget(MovieDetailModel? movie, BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(movie),
        body: movie != null
            ? _buildDetailRowWidget(movie, context)
            : const EmptySizedBoxShrink());
  }

  Widget _buildDetailRowWidget(MovieDetailModel movie, BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: Column(
        children: [
          CardWidget(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: _movieImageWidget(context, movie),
                ),
                Expanded(
                  flex: 6,
                  child: _buildDetailColumn(movie, context),
                )
              ],
            ),
          ),
          SizedBox(height: context.lowValue),
          Expanded(
              flex: 1,
              child: movie.genres.isNotNullOrEmpty
                  ? _buildMovieTypeWidget(context, movie)
                  : const EmptySizedBoxShrink())
        ],
      ),
    );
  }

  Padding _movieImageWidget(BuildContext context, MovieDetailModel movie) {
    return Padding(
      padding: context.paddingLow,
      child: Stack(
        children: [_buildMovieImage(movie), _buildVoteWidget(movie)],
      ),
    );
  }

  Widget _buildDetailColumn(MovieDetailModel movie, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleText(ApplicationConstants.instance.detailText),
          context.emptySizedHeightBoxLow,
          _buildMovieDetailWidget(movie),
        ],
      ),
    );
  }

  Widget _buildMovieTypeWidget(BuildContext context, MovieDetailModel movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildTitleText(ApplicationConstants.instance.typeText),
        _buildGenreWidget(context, movie),
      ],
    );
  }

  Widget _buildGenreWidget(BuildContext context, MovieDetailModel movie) {
    return SizedBox(
      height: context.dynamicHeight(0.1),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _buildGenreList(movie.genres!),
      ),
    );
  }

  Widget _buildMovieDetailWidget(MovieDetailModel movie) {
    return BodySmallText(maxLines: 10, movie.overview.toString(), context);
  }

  Positioned _buildVoteWidget(MovieDetailModel movie) {
    return Positioned(
        bottom: 5,
        left: 0,
        child: VoteCardWidget(
            context,
            movie.voteAverage != null
                ? movie.voteAverage!.toStringAsFixed(1)
                : ""));
  }

  MovieImageWidget _buildMovieImage(MovieDetailModel movie) {
    return MovieImageWidget(
        imagePath: (movie.posterPath ?? "").posterImagePath);
  }

  Widget _buildTitleText(String text) {
    return HeadLineText(text, context);
  }

  AppBar _buildAppBar(MovieDetailModel? movie) {
    return AppBar(
        centerTitle: false,
        title: FittedBox(
            child: HeadLineText(movie?.title ?? "".toString(), context)));
  }

  List<Widget> _buildGenreList(List<Genres> moviesGenres) {
    List<Widget> widgetList = [];
    for (var genreItem in moviesGenres) {
      if (genreItem.name.isNotNullOrNoEmpty) {
        widgetList.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: context.lowValue / 2),
          child: Chip(label: Text(genreItem.name ?? "")),
        ));
      }
    }
    return widgetList;
  }

  @override
  BuildContext get currentContext => context;
}
