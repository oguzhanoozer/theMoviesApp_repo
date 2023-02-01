import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:themoviesapp/feature/themoviesapp/movie_detail/model/movie_detail_model.dart';
import 'package:themoviesapp/feature/themoviesapp/movie_detail/viewmodel/movie_detail_view_cubit.dart';

import '../../../../product/constants/constants.dart';
import '../../../../product/widget/movie_image_load.dart';

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
    return BlocProvider<MovieDetailViewCubit>(
      create: (context) =>
          MovieDetailViewCubit()..fetchMovieDetail(movieId: widget.movieID),
      child: BlocConsumer<MovieDetailViewCubit, MovieDetailStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return state is MovieDetailLoading
              ? const Center(child: CircularProgressIndicator())
              : _buildScaffoldWidget(state, context);
        },
      ),
    );
  }

  Scaffold _buildScaffoldWidget(MovieDetailStates state, BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(state),
        body: _buildDetailRowWidget(state, context));
  }

  Row _buildDetailRowWidget(MovieDetailStates state, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: context.paddingLow,
            child: Stack(
              children: [_buildMovieImage(state), _buildVoteWidget(state)],
            ),
          ),
        ),
        state is MovieDetailLoaded && state.movie != null
            ? Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildTitleText(ApplicationConstants.detailText),
                    _buildMovieDetailWidget(state),
                    state.movie!.genres != null
                        ? _buildMovieTypeWidget(context, state)
                        : const SizedBox()
                  ],
                ),
              )
            : const SizedBox()
      ],
    );
  }

  Column _buildMovieTypeWidget(BuildContext context, MovieDetailLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTitleText(ApplicationConstants.typeText),
        SizedBox(
          height: context.dynamicHeight(0.4),
          child: ListView(
            children: _buildGenreList(state.movie!.genres!),
          ),
        ),
      ],
    );
  }

  Container _buildMovieDetailWidget(MovieDetailLoaded state) {
    return Container(
        padding: const EdgeInsets.all(5.0),
        constraints: const BoxConstraints.tightForFinite(),
        child: Text(state.movie!.overview.toString()));
  }

  Positioned _buildVoteWidget(MovieDetailStates state) {
    return Positioned(
        bottom: 5,
        left: 0,
        child: Card(
            color: Colors.grey,
            child: Padding(
              padding: context.paddingLow,
              child: _buildTitleText(
                state is MovieDetailLoaded && state.movie != null
                    ? state.movie!.voteAverage.toString()
                    : "",
              ),
            )));
  }

  MovieImageWidget _buildMovieImage(MovieDetailStates state) {
    return MovieImageWidget(
        imagePath: state is MovieDetailLoaded && state.movie != null
            ? state.movie!.posterPath!.posterImagePath
            : "");
  }

  Widget _buildTitleText(String text) {
    return Text(
      text,
      style: context.textTheme.headline6
          ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  AppBar _buildAppBar(MovieDetailStates state) {
    return AppBar(
      centerTitle: false,
      title: Text(
        state is MovieDetailLoaded && state.movie != null
            ? state.movie!.title.toString()
            : "",
      ),
    );
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
