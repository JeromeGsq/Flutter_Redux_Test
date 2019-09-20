import 'package:redux_oab/models/movie_result.dart';

class BusyAction {
  final bool isBusy;

  BusyAction({
    this.isBusy,
  });
}

class LoadHomePageMoviesAction {
  final int pageIndex;

  LoadHomePageMoviesAction({
    this.pageIndex,
  });
}

class ReceiveHomePageMoviesAction {
  final List<MovieResult> movies;

  ReceiveHomePageMoviesAction({
    this.movies,
  });
}

class IncrementCurrentPage {}
