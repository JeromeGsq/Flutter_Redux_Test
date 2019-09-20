import 'package:flutter/material.dart';
import 'package:redux_oab/enums/actions.dart';
import 'package:redux_oab/models/movie_result.dart';

@immutable
class AppState {
  final bool isBusy;

  final int nextPageIndex;
  final List<MovieResult> homepageMovies;

  const AppState(this.isBusy, this.nextPageIndex, this.homepageMovies);
}

AppState appStoreReducer(AppState state, dynamic action) {
  if (action is ReceiveHomePageMoviesAction) {
    state.homepageMovies.addAll(action.movies);
    return AppState(state.isBusy, state.nextPageIndex, state.homepageMovies);
  }

  if (action is IncrementCurrentPage) {
    return AppState(
        state.isBusy, state.nextPageIndex + 1, state.homepageMovies);
  }

  if (action is BusyAction) {
    return AppState(action.isBusy, state.nextPageIndex, state.homepageMovies);
  }

  return state;
}
