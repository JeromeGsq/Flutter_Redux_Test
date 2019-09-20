import 'package:flutter/material.dart';
import 'package:redux_oab/models/movie_result.dart';

@immutable
class HomePageState {
  HomePageState({
    @required this.isBusy,
    @required this.nextPageIndex,
    @required this.movies,
  });

  final bool isBusy;

  final int nextPageIndex;
  final List<MovieResult> movies;

  factory HomePageState.initial() {
    return HomePageState(
      isBusy: false,
      nextPageIndex: 0,
      movies: [],
    );
  }

  HomePageState copyWith({
    bool isBusy,
    int nextPageIndex,
    List<MovieResult> movies,
  }) {
    return HomePageState(
      isBusy: isBusy ?? this.isBusy,
      nextPageIndex: nextPageIndex ?? this.nextPageIndex,
      movies: movies ?? this.movies,
    );
  }
}
