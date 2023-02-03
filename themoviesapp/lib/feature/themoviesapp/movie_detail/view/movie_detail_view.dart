import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:themoviesapp/feature/themoviesapp/movie_detail/model/movie_detail_model.dart';
import 'package:themoviesapp/feature/themoviesapp/movie_detail/service/movie_detail_service.dart';

import '../../../../network/network_manager.dart';
import '../../../../product/constants/application_constants.dart';
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

class _MovieDetailViewState extends State<MovieDetailView> {
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
        listener: (context, state) {},
        builder: (context, state) {
          return state.isLoading ?? false
              ? const Center(child: CircularProgressIndicator())
              : _buildScaffoldWidget(state, context);
        },
      ),
    );
  }

  Scaffold _buildScaffoldWidget(MovieDetailState state, BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(state),
        body: _buildDetailRowWidget(state, context));
  }

  Row _buildDetailRowWidget(MovieDetailState state, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: _movieImageWidget(context, state),
        ),
        state.movie != null
            ? Expanded(
                flex: 1,
                child: _buildDetailColumn(state, context),
              )
            : const EmptySizedBoxShrink()
      ],
    );
  }

  Padding _movieImageWidget(BuildContext context, MovieDetailState state) {
    return Padding(
      padding: context.paddingLow,
      child: Stack(
        children: [_buildMovieImage(state), _buildVoteWidget(state)],
      ),
    );
  }

  Column _buildDetailColumn(MovieDetailState state, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTitleText(ApplicationConstants.instance.detailText),
        _buildMovieDetailWidget(state),
        state.movie!.genres != null
            ? _buildMovieTypeWidget(context, state)
            : const EmptySizedBoxShrink()
      ],
    );
  }

  Column _buildMovieTypeWidget(BuildContext context, MovieDetailState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTitleText(ApplicationConstants.instance.typeText),
        _buildGenreWidget(context, state),
      ],
    );
  }

  SizedBox _buildGenreWidget(BuildContext context, MovieDetailState state) {
    return SizedBox(
      height: context.dynamicHeight(0.4),
      child: ListView(
        children: _buildGenreList(state.movie!.genres!),
      ),
    );
  }

  Container _buildMovieDetailWidget(MovieDetailState state) {
    return Container(
        padding: const EdgeInsets.all(5.0),
        constraints: const BoxConstraints.tightForFinite(),
        child: BodyMediumText(state.movie!.overview.toString(), context));
  }

  Positioned _buildVoteWidget(MovieDetailState state) {
    return Positioned(
        bottom: 5,
        left: 0,
        child: VoteCardWidget(
            context,
            state is MovieDetailState && state.movie != null
                ? state.movie!.voteAverage.toString()
                : ""));
  }

  MovieImageWidget _buildMovieImage(MovieDetailState state) {
    return MovieImageWidget(
        imagePath: state.movie != null
            ? state.movie!.posterPath!.posterImagePath
            : "");
  }

  Widget _buildTitleText(String text) {
    return BodyMediumText(text, context);
  }

  AppBar _buildAppBar(MovieDetailState state) {
    return AppBar(
        centerTitle: false,
        title: HeadLineText(
            state.movie != null ? state.movie!.title.toString() : "", context));
  }

  List<Widget> _buildGenreList(List<Genres> moviesGenres) {
    List<Widget> widgetList = [];
    for (var genreItem in moviesGenres) {
      if (genreItem.name.isNotNullOrNoEmpty) {
        widgetList.add(Chip(label: Text(genreItem.name ?? "")));
      }
    }
    return widgetList;
  }
}
