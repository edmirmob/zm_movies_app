import 'package:flutter/foundation.dart';

import '../../core/models/movies_data.dart';

class MoviesState {
  final List<MoviesData> movies;
  final int page;
  final int totalCount;
  final bool loadingFirstPage;
  final bool loadingMoreData;
  final bool inProgress;

  MoviesState({
    @required this.movies,
    @required this.page,
    @required this.totalCount,
    @required this.loadingFirstPage,
    @required this.loadingMoreData,
    @required this.inProgress,
  });

  MoviesState copyWith({
    List<MoviesData> movies,
    int page,
    int totalCount,
    bool loadingFirstPage,
    bool loadingMoreData,
    bool inProgress,
  }) {
    return MoviesState(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      totalCount: totalCount ?? this.totalCount,
      loadingFirstPage: loadingFirstPage ?? this.loadingFirstPage,
      loadingMoreData: loadingMoreData ?? this.loadingMoreData,
      inProgress: inProgress ?? this.inProgress,
    );
  }
}

class MoviesInitialState extends MoviesState {
  MoviesInitialState()
      : super(
          movies: [],
          page: -1,
          totalCount: -1,
          loadingFirstPage: true,
          loadingMoreData: false,
          inProgress: false,
        );
}
