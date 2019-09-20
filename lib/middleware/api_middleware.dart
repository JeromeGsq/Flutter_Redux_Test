import 'package:redux_oab/data_providers/api.dart';
import 'package:redux_oab/enums/actions.dart';
import 'package:redux_oab/state/appstate.dart';
import 'package:redux/redux.dart';

Future apiMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) async {
  if (action is LoadHomePageMoviesAction) {
    store.dispatch(BusyAction(isBusy: true));

    // TODO: don't do that
    var movies = await ApiClient().getHomePageMovies(action.pageIndex);
    store.dispatch(ReceiveHomePageMoviesAction(movies: movies));
    store.dispatch(IncrementCurrentPage());
    store.dispatch(BusyAction(isBusy: false));
    /*
        .then((w) => store.dispatch(ReceiveHomePageMoviesAction(movies: w)))
        .then((_) => store.dispatch(IncrementCurrentPage()))
        .then((_) => store.dispatch(BusyAction(isBusy: false)));
        */
  }

  next(action);
}
