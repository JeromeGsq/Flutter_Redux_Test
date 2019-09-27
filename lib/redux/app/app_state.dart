import 'package:flutter/material.dart';
import 'package:redux_oab/redux/homepage/homepage_state.dart';
import 'package:redux_oab/redux/movie_details/movie_details_state.dart';

@immutable
class AppStore {
  const AppStore({
    this.homePageState,
    this.movieDetailsState,
  });

  final HomePageState homePageState;
  final MovieDetailsState movieDetailsState;

  factory AppStore.initial() {
    return AppStore(
      homePageState: HomePageState.initial(),
      movieDetailsState: MovieDetailsState.initial(),
    );
  }
}
