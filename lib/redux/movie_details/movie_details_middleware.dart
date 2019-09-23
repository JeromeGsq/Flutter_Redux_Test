import 'package:redux_oab/networking/api.dart';
import 'package:redux/redux.dart';
import 'package:redux_oab/redux/app/app_actions.dart';
import 'package:redux_oab/redux/app/app_state.dart';

import 'movie_details_actions.dart';

class MovieDetailsMiddleware extends MiddlewareClass<AppState> {
  @override
  Future<Null> call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is LoadMovieAction) {
      store.dispatch(BusyAction(isBusy: true));

      // TODO: don't do that
      var movie = await ApiClient().getMovie(action.id);
      await Future.delayed(Duration(seconds: 1));
      store.dispatch(MovieLoadedAction(movie: movie));
      store.dispatch(BusyAction(isBusy: false));
    }

    if (action is LoadFullDescriptionAction) {
      store.dispatch(BusyAction(isBusy: true));

      // TODO: don't do that
      var movie = await ApiClient().getMovie(action.id, fullDescription: true);
      await Future.delayed(Duration(seconds: 1));
      store.dispatch(FullDescriptionLoadedAction(fullDescription: movie.plot));
      store.dispatch(BusyAction(isBusy: false));
    }

    next(action);
  }
}
