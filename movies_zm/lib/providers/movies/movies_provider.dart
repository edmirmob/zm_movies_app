import 'dart:async';

import 'package:state_notifier/state_notifier.dart';

import '../../common/alert_dialog.dart';
import '../../core/models/movies_data.dart';
import '../../core/models/paged_data.dart';
import '../../core/repositories/movies_repository.dart';
import 'movies_state.dart';

class MoviesProvider extends StateNotifier<MoviesState> with LocatorMixin {
  MoviesProvider() : super(MoviesInitialState());

  bool isMoviesLoaded() {
    return state.movies.isNotEmpty;
  }

  Future<void> loadMovies() async {
    if (!state.inProgress) {
      try {
        state = state.copyWith(loadingFirstPage: true, inProgress: true);
        final nextPage = 0;
        final result = await _getMovies(
          nextPage,
        );
        state = state.copyWith(
          loadingFirstPage: false,
          inProgress: false,
          movies: [...result.items],
          page: result.page,
          totalCount: result.totalCount,
        );
      } catch (_) {
        _onMoviesLoadingError();
      }
    }
  }

  Future<void> loadMoreMovies() async {
    if (!state.inProgress &&
        state.page > -1 &&
        state.movies.length < state.totalCount) {
      try {
        state = state.copyWith(loadingMoreData: true, inProgress: true);
        final nextPage = state.page + 1;
        final result = await _getMovies(
          nextPage,
        );
        state = state.copyWith(
          loadingMoreData: false,
          inProgress: false,
          movies: [...state.movies, ...result.items],
          totalCount: result.totalCount,
          page: result.page + 1,
        );
      } catch (_) {
        _onMoviesLoadingError();
      }
    }
  }

  Future<void> refreshMovies() async {
    if (!state.inProgress) {
      state = state.copyWith(inProgress: true);
      const nextPage = 0;
      final result = await _getMovies(
        nextPage,
      );
      state = state.copyWith(
        inProgress: false,
        movies: [...result.items],
        totalCount: result.totalCount,
        page: nextPage,
      );
    }
  }

  Future<PagedData<MoviesData>> _getMovies(
    int page,
  ) {
    return read<MoviesRepository>().getMovies();
  }

  void _onMoviesLoadingError() {
    state = state.copyWith(inProgress: false);
    showAlertDialog(('Can\'t load movies'),
        ('There was an error while loading movies. Please try again later.'));
  }
}
