import 'package:flutter/material.dart';
import 'package:redux_oab/redux/homepage/homepage_state.dart';
import 'package:redux_oab/redux/movie_details/movie_details_state.dart';

@immutable
class AppState {
  const AppState({
    this.homePageState,
    this.movieDetailsState,
  });

  final HomePageState homePageState;
  final MovieDetailsState movieDetailsState;

  factory AppState.initial() {
    return AppState(
      homePageState: HomePageState.initial(),
      movieDetailsState: MovieDetailsState.initial(),
    );
  }
}
