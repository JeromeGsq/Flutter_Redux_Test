import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_oab/models/movie_result.dart';
import 'package:redux_oab/redux/app/app_state.dart';
import 'package:redux_oab/redux/movie_details/movie_details_actions.dart';
import 'package:redux_oab/redux/movie_details/movie_details_state.dart';

class MovieDetailsPage extends StatefulWidget {
  final MovieResult movieResult;

  const MovieDetailsPage(
    this.movieResult, {
    Key key,
  }) : super(key: key);

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MovieDetailsState>(
      onInit: (store) => store.dispatch(
        LoadMovieAction(id: widget.movieResult.imdbID),
      ),
      converter: (store) => store?.state?.movieDetailsState,
      builder: (context, movieDetailsState) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text(
              widget.movieResult?.title.toString(),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  CachedNetworkImage(
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                    imageUrl: movieDetailsState?.movie?.poster ?? "",
                    placeholder: (context, url) => SizedBox(
                      child: Icon(Icons.image),
                    ),
                    errorWidget: (context, url, error) => SizedBox(
                      child: Icon(Icons.error),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            movieDetailsState.descriptionIsCollapsed
                                ? movieDetailsState?.movie?.plot.toString()
                                : movieDetailsState?.fullDescription.toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                          MaterialButton(
                            child: movieDetailsState.isBusy
                                ? CircularProgressIndicator()
                                : Icon(movieDetailsState.descriptionIsCollapsed
                                    ? Icons.keyboard_arrow_down
                                    : Icons.keyboard_arrow_up),
                            onPressed: () {
                              if (movieDetailsState?.fullDescription?.isEmpty ?? true) {
                                StoreProvider.of<AppState>(context)
                                    .dispatch(LoadFullDescriptionAction(id: movieDetailsState?.movie?.imdbID));
                              } else {
                                StoreProvider.of<AppState>(context).dispatch(SwitchDescriptionStatus());
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}