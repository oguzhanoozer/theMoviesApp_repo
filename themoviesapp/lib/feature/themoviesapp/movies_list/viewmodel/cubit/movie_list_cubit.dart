import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:themoviesapp/feature/themoviesapp/movies_list/service/movies_list_service.dart';
import '../../../../../product/constants/application_constants.dart';
import '../../../../../product/mixin/error_mixin.dart';
import '../../model/movie_list_model.dart';
import 'movie_list_state.dart';
import 'package:kartal/kartal.dart';

class MovieListCubit extends Cubit<MovieListState> {
  MovieListCubit(this.moviesListService) : super(MovieListState()) {
    initialComplete();
  }
  final IMoviesListService moviesListService;

  String searchOldValue = "";

  Future<void> initialComplete() async {
    await Future.microtask(() {
      emit(MovieListState(isInitial: true));
    });

    await Future.wait([fetchMovieList()]);
    emit(state.copyWith(filteredList: state.movieAllList));
  }

  Future<void> fetchMovieList() async {
    _changeLoading();

    try {
      final movieListResponse =
          await moviesListService.getMoviesList(pageValue: kOne.toInt());
      emit(state.copyWith(movieAllList: movieListResponse?.results ?? []));
    } catch (e) {
      emit(state.copyWith(isError: true));
    }

    _changeLoading();
  }

  Future<void> fetchMoreDataList({String value = ""}) async {
    if (state.isUpdated) {
      if (value.isNotEmpty) {
        await fetchNewFilterMoviesByItems(value);
      }
    } else {
      await fetchNewMovies();
    }
  }

  Future<void> fetchNewMovies() async {
    if (state.moviesListFull ?? false || (state.isLoading ?? false)) {
      return;
    }
    _changeLoading();
    try {
      int pageNumber = (state.pageNumber ?? kOne.toInt());

      final movieListResponse =
          await moviesListService.getMoviesList(pageValue: ++pageNumber);

      final movieList = movieListResponse?.results ?? [];
      if (movieList.isNotEmpty || state.movieAllList.isNotNullOrEmpty) {
        state.movieAllList!.addAll(movieList);

        emit(state.copyWith(
            movieAllList: state.movieAllList!,
            filteredList: state.movieAllList!,
            moviesListFull: movieListResponse?.totalPages == pageNumber,
            pageNumber: movieListResponse?.page));
      }
    } catch (e) {
      emit(state.copyWith(isError: true));
    }
    _changeLoading();
  }

  Future<void> fetchMoviesByItems(String searchValue) async {
    if (searchValue.isEmpty || searchOldValue == searchValue) {
      return;
    } else {
      _changeLoading();
      try {
        searchOldValue = searchValue;
        emit(state.copyWith(
            filterListFull: false,
            pageFilterNumber: kOne.toInt(),
            filteredList: state.movieAllList));

        late MoviesListModel? movieSearchListResponse;
        List<Movie> resultList = [];
        CancelableOperation<void>? cancellableOperation;
        cancellableOperation?.cancel();
        cancellableOperation = CancelableOperation.fromFuture(
          Future.delayed(Durations.normal.value),
          onCancel: () {
            ErrorsMixin.print(
                ApplicationConstants.instance.operationWasCancelled);
          },
        );

        await cancellableOperation.value.then((value) async {
          movieSearchListResponse = await moviesListService.getSearchMoviesList(
              textValue: searchOldValue.toLowerCase(), pageValue: kOne.toInt());

          resultList = movieSearchListResponse?.results ?? [];
        });

        emit(state.copyWith(
          isUpdated: true,
          filteredList: resultList,
        ));
      } catch (e) {
        emit(state.copyWith(isError: true));
      }
      _changeLoading();
    }
  }

  bool isAllFetchData() {
    return state.isUpdated
        ? state.filterListFull ?? false
        : state.moviesListFull ?? false;
  }

  Future<void> fetchNewFilterMoviesByItems(String searchValue) async {
    if ((state.filterListFull ?? false) ||
        (searchValue.isEmpty && (state.isLoading ?? false))) {
      return;
    } else {
      _changeLoading();
      try {
        int pageNumber = (state.pageFilterNumber ?? kOne.toInt());

        final movieListResponse = await moviesListService.getSearchMoviesList(
            textValue: searchValue.toLowerCase(), pageValue: ++pageNumber);

        final movieList = movieListResponse?.results ?? [];

        if (movieList.isNotNullOrEmpty && state.filteredList.isNotNullOrEmpty) {
          state.filteredList!.addAll(movieList);

          emit(state.copyWith(
              filterListFull: movieListResponse?.totalPages == pageNumber,
              filteredList: state.filteredList!,
              pageFilterNumber: movieListResponse?.page));
        }
      } catch (e) {
        emit(state.copyWith(isError: true));
      }
      _changeLoading();
    }
  }

  void changeIsUpdate() {
    emit(state.copyWith(
        isUpdated: !(state.isUpdated),
        filterListFull: false,
        filteredList: state.movieAllList));
  }

  void _changeLoading() {
    emit(state.copyWith(isLoading: !(state.isLoading ?? false)));
  }
}
