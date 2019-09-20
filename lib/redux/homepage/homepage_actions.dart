import 'package:redux_oab/models/movie_result.dart';

class LoadHomePageMoviesAction {
  final int pageIndex;

  LoadHomePageMoviesAction({
    this.pageIndex,
  });
}

class HomePageMoviesLoadedAction {
  final List<MovieResult> movies;

  HomePageMoviesLoadedAction({
    this.movies,
  });
}

class IncrementCurrentPage {}
