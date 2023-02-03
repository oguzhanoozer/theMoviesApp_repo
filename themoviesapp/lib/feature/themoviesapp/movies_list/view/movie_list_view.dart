import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:themoviesapp/feature/product/widget/text_widgets.dart';
import 'package:themoviesapp/feature/themoviesapp/movies_list/model/movie_list_model.dart';
import 'package:themoviesapp/feature/themoviesapp/movies_list/service/movies_list_service.dart';
import 'package:themoviesapp/product/constants/application_constants.dart';
import 'package:themoviesapp/product/route/generate_route.dart';
import 'package:themoviesapp/product/widget/empty_sizedbox_shrink.dart';

import '../../../../network/network_manager.dart';
import '../../../../product/mixin/mixin_utility.dart';
import '../../../../product/widget/loading_circular.dart';
import '../../../../product/widget/textfield_decoration.dart';
import '../../../product/widget/movie_card.dart';
import '../viewmodel/cubit/movie_list_cubit.dart';
import '../viewmodel/cubit/movie_list_state.dart';

class MovieListView extends StatefulWidget {
  const MovieListView({Key? key}) : super(key: key);
  @override
  State<MovieListView> createState() => _MovieListViewState();
}

class _MovieListViewState extends State<MovieListView>
    with SnackBarWidgetMixin {
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
          if (state.isError) {
            buildSnackBar();
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
      body: CustomScrollView(
        ///physics: const ScrollPhysics().,
        controller: _scrollController,
        slivers: [
          _buildSliverApp(state, context),
          _buildMoviesListView(context),
          SliverToBoxAdapter(
            child: state.filterListFull ?? false
                ? _allItemsFetchText(context)
                : SizedBox(
                    height: context.dynamicHeight(0.1),
                    child: _loadingCenter()),
          ),
        ],
      ),
      //   bottomNavigationBar: _textWrite(),
    );
  }

  Center _allItemsFetchText(BuildContext context) {
    return Center(
      child: Padding(
        padding: context.paddingLow,
        child: BodyMediumText(
            ApplicationConstants.instance.allItemsFetched, context),
      ),
    );
  }

  SliverAppBar _buildSliverApp(MovieListState state, BuildContext context) {
    return SliverAppBar(
      toolbarHeight: context.dynamicHeight(0.08),
      title: Column(
        children: [
          _buildTextFieldContainer(state, context),
        ],
      ),
      // actions: [_loadingCenter()],
      centerTitle: true,
      pinned: true,
    );
  }

  Container _buildTextFieldContainer(
      MovieListState state, BuildContext context) {
    return Container(
        height: context.dynamicHeight(0.06),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
        child: TextFieldProduct(
          onChanged: (value) async {
            if (value.length > 2) {
              await context.read<MovieListCubit>().fetchMoviesByItems(value);
            } else {
              context.read<MovieListCubit>().changeIsUpdate();
            }
          },
          textEditingController: _editingController,
        ));
  }

  Widget _buildMoviesListView(BuildContext context) {
    return BlocBuilder<MovieListCubit, MovieListState>(
      builder: (context, state) {
        final list = state.filteredList ?? [];
        print(list.length);
        return SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, movieDetailViewRoute,
                      arguments: list[index].id);
                },
                child: MovieCard(movie: list[index], context: context),
              );
            },
            childCount: list.length,
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
            ? const Center(child: LoadingCircularProduct())
            : const EmptySizedBoxShrink();
      },
    );
  }

  // Widget _textWrite() {
  //   return BlocSelector<MovieListCubit, MovieListState, bool>(
  //     selector: (state) {
  //       var filterFull = state.filterListFull ?? false;
  //       var movieFull = state.moviesListFull ?? false;
  //       return filterFull || movieFull;
  //     },
  //     builder: (context, state) {
  //       return state ? Text("hepsi bura") : SizedBox.shrink();
  //     },
  //   );
  // }

  @override
  BuildContext get currentContext => context;
}
