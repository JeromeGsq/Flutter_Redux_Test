import 'package:redux_oab/redux/app/app_actions.dart';
import 'package:redux_oab/redux/movie_details/movie_details_actions.dart';
import 'package:redux_oab/redux/movie_details/movie_details_state.dart';

MovieDetailsState movieDetailsReducer(MovieDetailsState state, dynamic action) {
  if (action is BusyAction) {
    return state.copyWith(
      isBusy: action.isBusy,
    );
  }

  if (action is LoadMovieAction) {
    //return MovieDetailsState(isBusy: false, descriptionIsCollapsed: true, movieResult: state.movieResult);
  }

  if (action is AssignMovieResultAction) {
    return state.copyWith(
      movieResult: state.movieResult,
    );
  }

  if (action is MovieLoadedAction) {
    return state.copyWith(
      movie: action.movie,
    );
  }

  if (action is FullDescriptionLoadedAction) {
    return state.copyWith(
      fullDescription: action.fullDescription,
      descriptionIsCollapsed: false,
    );
  }

  if (action is SwitchDescriptionStatus) {
    return state.copyWith(
      descriptionIsCollapsed: !state.descriptionIsCollapsed,
    );
  }

  return state;
}
