import 'package:redux_oab/redux/app/app_state.dart';
import 'package:redux_oab/redux/homepage/homepage_reducer.dart';
import 'package:redux_oab/redux/movie_details/movie_details_reducer.dart';

AppStore appStoreReducer(AppStore state, dynamic action) {
  return AppStore(
    homePageState: homePageReducer(state.homePageState, action),
    movieDetailsState: movieDetailsReducer(state.movieDetailsState, action),
  );
}
