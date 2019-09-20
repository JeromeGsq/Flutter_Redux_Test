import 'package:flutter/material.dart';

@immutable
class MovieDetailsState {
  final bool isBusy;

  final String title;
  final String imageUrl;

  const MovieDetailsState(this.isBusy, this.title, this.imageUrl);
}

MovieDetailsState movieDetailsReducer(MovieDetailsState state, dynamic action) {
  return state;
}
