import 'package:redux_oab/networking/api.dart';
import 'package:redux/redux.dart';
import 'package:redux_oab/redux/app/app_actions.dart';
import 'package:redux_oab/redux/app/app_state.dart';
import 'package:redux_oab/redux/homepage/homepage_actions.dart';

class HomepageMiddleware extends MiddlewareClass<AppStore> {
  @override
  Future<Null> call(Store<AppStore> store, dynamic action, NextDispatcher next) async {
    if (action is LoadHomePageMoviesAction) {
      store.dispatch(BusyAction(isBusy: true));

      // TODO: don't do that
      var movies = await ApiClient().getHomePageMovies(action.pageIndex);
      await Future.delayed(Duration(seconds: 1));
      store.dispatch(HomePageMoviesLoadedAction(movies: movies));
      store.dispatch(IncrementCurrentPage());
      store.dispatch(BusyAction(isBusy: false));
    }

    next(action);
  }
}
