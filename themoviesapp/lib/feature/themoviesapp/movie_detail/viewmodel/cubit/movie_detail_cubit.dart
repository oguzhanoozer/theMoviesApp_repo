import 'package:flutter_bloc/flutter_bloc.dart';
import '../../service/movie_detail_service.dart';
import 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit(this.moviesDetailService) : super(MovieDetailState());

  final IMovieDetailService moviesDetailService;

  Future<void> initialComplete() async {}

  Future<void> fetchMovieDetail({required int movieId}) async {
    _changeLoading();
    final movieDetail =
        await moviesDetailService.getMovieDetail(movieId: movieId);

    emit(state.copyWith(movie: movieDetail));
    _changeLoading();
  }

  void _changeLoading() {
    emit(state.copyWith(isLoading: !(state.isLoading ?? false)));
  }
}
