import 'package:redux_oab/models/movie.dart';
import 'package:redux_oab/models/movie_result.dart';

class AssignMovieResultAction {
  final MovieResult movieResult;

  AssignMovieResultAction({
    this.movieResult,
  });
}

class LoadMovieAction {
  final String id;

  LoadMovieAction({
    this.id,
  });
}

class LoadFullDescriptionAction {
  final String id;

  LoadFullDescriptionAction({
    this.id,
  });
}

class MovieLoadedAction {
  final Movie movie;

  MovieLoadedAction({
    this.movie,
  });
}

class FullDescriptionLoadedAction {
  final String fullDescription;

  FullDescriptionLoadedAction({
    this.fullDescription,
  });
}

class SwitchDescriptionStatus {}

class ClearMovieDetails {}
