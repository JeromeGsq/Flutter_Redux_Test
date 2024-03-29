import 'package:flutter/material.dart';
import 'package:redux_oab/models/movie.dart';
import 'package:redux_oab/models/movie_result.dart';

@immutable
class MovieDetailsState {
  MovieDetailsState({
    @required this.isBusy,
    @required this.showFullDescription,
    this.movieResult,
    this.movie,
    this.fullDescription,
  });

  final bool isBusy;
  final bool showFullDescription;
  final MovieResult movieResult;
  final Movie movie;
  final String fullDescription;

  factory MovieDetailsState.initial() {
    return MovieDetailsState(
      isBusy: false,
      showFullDescription: false,
      movieResult: null,
      movie: null,
      fullDescription: "",
    );
  }

  MovieDetailsState copyWith({
    bool isBusy,
    bool descriptionIsCollapsed,
    MovieResult movieResult,
    Movie movie,
    String fullDescription,
  }) {
    return MovieDetailsState(
      isBusy: isBusy ?? this.isBusy,
      showFullDescription: descriptionIsCollapsed ?? this.showFullDescription,
      movieResult: movieResult ?? this.movieResult,
      movie: movie ?? this.movie,
      fullDescription: fullDescription ?? this.fullDescription,
    );
  }
}
