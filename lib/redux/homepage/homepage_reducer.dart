import 'package:redux_oab/redux/app/app_actions.dart';
import 'package:redux_oab/redux/homepage/homepage_actions.dart';
import 'package:redux_oab/redux/homepage/homepage_state.dart';

HomePageState homePageReducer(HomePageState state, dynamic action) {
  if (action is HomePageMoviesLoadedAction) {
    if (action?.movies != null) {
      state.movies.addAll(action.movies);
    }
    return state.copyWith(
      movies: state.movies,
    );
  }

  if (action is IncrementCurrentPage) {
    return state.copyWith(
      nextPageIndex: state.nextPageIndex + 1,
    );
  }

  if (action is BusyAction) {
    return state.copyWith(
      isBusy: action.isBusy,
    );
  }

  return state;
}
