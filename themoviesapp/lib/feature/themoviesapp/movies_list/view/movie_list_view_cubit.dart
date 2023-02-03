import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:themoviesapp/feature/themoviesapp/movies_list/model/movie_list_model.dart';
import 'package:themoviesapp/feature/themoviesapp/movies_list/service/movies_list_service.dart';
import 'package:themoviesapp/product/constants/application_constants.dart';
import 'package:themoviesapp/product/route/generate_route.dart';

import '../../../../network/network_manager.dart';
import '../../../product/widget/movie_card.dart';
import '../viewmodel/cubit/movie_list_cubit.dart';
import '../viewmodel/cubit/movie_list_state.dart';

class MovieListView extends StatefulWidget {
  const MovieListView({Key? key}) : super(key: key);
  @override
  State<MovieListView> createState() => _MovieListViewState();
}

class _MovieListViewState extends State<MovieListView> {
  final _scrollController = ScrollController();
  final TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _listenScroll(BuildContext context) {
    _scrollController.addListener(() async {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        await context
            .read<MovieListCubit>()
            .fetchMoreDataList(value: _editingController.text);

        ///context.read<MovieCubit>().fetchNewMovies();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieListCubit>(
      create: (context) =>
          MovieListCubit(MoviesListService(NetworkManager.instance.dio)),
      child: BlocConsumer<MovieListCubit, MovieListState>(
        listener: (context, state) {
          if (state.isInitial) {
            _listenScroll(context);
          }
        },
        builder: (context, state) {
          return _buildScaffoldWidget(state, context);
        },
      ),
    );
  }

  Scaffold _buildScaffoldWidget(MovieListState state, BuildContext context) {
    return Scaffold(
        body: NotificationListener<ScrollNotification>(
      // onNotification: (notification) {
      //   if (notification is ScrollEndNotification) {
      //     ///   context.read<MovieCubit>().fetchNewMovies();
      //   }
      //   return true;
      // },
      child: CustomScrollView(
        ///physics: const ScrollPhysics().,
        controller: _scrollController,
        slivers: [
          _buildSliverApp(state, context),
          _buildMoviesListView(context),
        ],
      ),
    ));
  }

  SliverAppBar _buildSliverApp(MovieListState state, BuildContext context) {
    return SliverAppBar(
      toolbarHeight: context.dynamicHeight(0.08),
      title: Column(
        children: [
          _buildTextFieldContainer(state, context),
        ],
      ),
      actions: [_loadingCenter()],
      centerTitle: true,
      pinned: true,
    );
  }

  Container _buildTextFieldContainer(
      MovieListState state, BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.06),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
      child: TextField(
        controller: _editingController,
        decoration: _buildTextDecoration(),
        onChanged: (value) async {
          if (value.length > 2) {
            await context.read<MovieListCubit>().fetchMoviesByItems(value);
          } else {
            context.read<MovieListCubit>().changeIsUpdate();
          }
        },
      ),
    );
  }

  InputDecoration _buildTextDecoration() {
    return InputDecoration(
      hintText: ApplicationConstants.instance.searchMovies,
      border: InputBorder.none,
      icon: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: ApplicationConstants.instance.greyColor,
          )),
    );
  }

  Widget _buildMoviesListView(BuildContext context) {
    return BlocSelector<MovieListCubit, MovieListState, List<Movie>>(
      selector: (state) {
        return state.filteredList ?? [];
      },
      builder: (context, state) {
        return SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, movieDetailViewRoute,
                      arguments: state[index].id);
                },
                child: MovieCard(movie: state[index], context: context),
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

  Widget _loadingCenter() {
    return BlocSelector<MovieListCubit, MovieListState, bool>(
      selector: (state) {
        return state.isLoading ?? false;
      },
      builder: (context, state) {
        return state
            ? Center(child: CircularProgressIndicator())
            : SizedBox.shrink();
      },
    );
  }
}
