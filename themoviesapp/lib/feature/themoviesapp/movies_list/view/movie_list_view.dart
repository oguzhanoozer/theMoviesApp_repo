import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:themoviesapp/feature/themoviesapp/movies_list/model/movie_list_model.dart';
import 'package:themoviesapp/feature/themoviesapp/movies_list/viewmodel/movie_list_cubit.dart';
import 'package:themoviesapp/product/constants/constants.dart';
import 'package:themoviesapp/product/route/generate_route.dart';

import '../../../../product/widget/movie_image_load.dart';

class MovieListView extends StatefulWidget {
  const MovieListView({Key? key}) : super(key: key);
  @override
  State<MovieListView> createState() => _MovieListViewState();
}

class _MovieListViewState extends State<MovieListView> {
  ScrollController _scroolController = ScrollController();
  TextEditingController _editingController = TextEditingController();
  MovieListCubit movieListCubit = MovieListCubit();

  @override
  void initState() {
    super.initState();
    // _scroolController.addListener(() async {
    //   double maxScroll = _scroolController.position.maxScrollExtent;
    //   double currentScroll = _scroolController.position.pixels;
    //   double delta = context.dynamicHeight(0.2);

    //   if (maxScroll - currentScroll <= delta) {
    //     if (movieListCubit.hasNextData) {
    //       await movieListCubit.fetchMoreMovieList();
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieListCubit>(
      create: (context) => MovieListCubit()..fetchMovieList(),
      child: BlocConsumer<MovieListCubit, MovieListStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return _buildScaffoldWidget(state, context);
        },
      ),
    );
  }

  Scaffold _buildScaffoldWidget(MovieListStates state, BuildContext context) {
    return Scaffold(
        body: NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (state is MovieListLoaded) {
            if ((state).hasNextData) {
              context.read<MovieListCubit>().fetchMoreMovieList();
            }
          }
        }
        return true;
      },
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        controller: _scroolController,
        slivers: [
          _buildSliverApp(context),
          state is MovieListLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                ).sliver
              : _buildMoviesListView(context),
        ],
      ),
    ));
  }

  SliverAppBar _buildSliverApp(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: context.dynamicHeight(0.08),
      title: Column(
        children: [
          _buildTextFieldContainer(context),
        ],
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      pinned: true,
    );
  }

  Container _buildTextFieldContainer(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.06),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(5.0)),
      child: TextField(
        controller: _editingController,
        decoration: _buildTextDecoration(),
        onChanged: (value) async {
          // if (value.isNotEmpty) {
          await context.read<MovieListCubit>().fetchMoviesByItems(value);
          //}
        },
      ),
    );
  }

  InputDecoration _buildTextDecoration() {
    return InputDecoration(
      hintText: ApplicationConstants.searchMovies,
      border: InputBorder.none,
      icon: IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
    );
  }

  Widget _buildMoviesListView(BuildContext context) {
    return BlocSelector<MovieListCubit, MovieListStates, List<Movie>>(
      selector: (state) {
        print("state   " + state.toString());
        return state is MovieListLoaded
            ? state.movieList ?? []
            : context.read<MovieListCubit>().movieAllList;
      },
      builder: (context, state) {
        print("BlocSelector  " + state.length.toString());
        return SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, movieDetailViewRoute,
                      arguments: state[index].id);
                },
                child: _buildMoviesCardWidget(state, index, context),
              );
            },
            childCount: state.length,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            // mainAxisSpacing: 0,
            // crossAxisSpacing: 0,
            childAspectRatio: 0.5,
          ),
        );
      },
    );
  }

  Card _buildMoviesCardWidget(
      List<Movie> state, int index, BuildContext context) {
    return Card(
      child: Column(children: [
        Expanded(flex: 3, child: _buildImageStack(state, index, context)),
        Expanded(
            flex: 1,
            child: Padding(
              padding: context.paddingLow,
              child: Text(
                state[index].title ?? "",
              ),
            )),
        state.isNotNullOrEmpty && index == state.length - 1
            ? const CircularProgressIndicator()
            : const SizedBox()
      ]),
    );
  }

  Stack _buildImageStack(List<Movie> state, int index, BuildContext context) {
    return Stack(
      children: [
        MovieImageWidget(imagePath: state[index].posterPath!.posterImagePath),
        Positioned(
            bottom: 10,
            right: 0,
            child: _buildImageCarWidget(context, state, index))
      ],
    );
  }

  Card _buildImageCarWidget(
      BuildContext context, List<Movie> state, int index) {
    return Card(
        color: Colors.grey,
        child: Padding(
          padding: context.paddingLow,
          child: Text(
            state[index].voteAverage.toString(),
            style: context.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ));
  }
}
