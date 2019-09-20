import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:redux_oab/modules/homepage/home_page.dart';
import 'package:redux_oab/modules/movie_details/movie_details_page.dart';
import 'package:redux_oab/redux/app/app_reducer.dart';
import 'package:redux_oab/redux/app/app_state.dart';
import 'package:redux_oab/redux/homepage/homepage_actions.dart';
import 'package:redux_oab/redux/homepage/homepage_middleware.dart';
import 'package:redux_oab/redux/movie_details/movie_details_middleware.dart';

void main() {
  final store = Store<AppState>(appStoreReducer,
      initialState: AppState.initial(),
      middleware: <Middleware<AppState>>[
        HomepageMiddleware(),
        MovieDetailsMiddleware(),
        NavigationMiddleware<AppState>(),
      ]);

  runApp(FlutterReduxApp(
    title: 'Flutter Redux OAB Demo',
    store: store,
  ));
}

class FlutterReduxApp extends StatefulWidget {
  final Store<AppState> store;
  final String title;

  FlutterReduxApp({Key key, this.store, this.title}) : super(key: key);

  @override
  _FlutterReduxAppState createState() => _FlutterReduxAppState();
}

class _FlutterReduxAppState extends State<FlutterReduxApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        theme: ThemeData.light(),
        title: widget.title,
        navigatorKey: NavigatorHolder.navigatorKey,
        onGenerateRoute: _getRoute,
        home: const HomePage(),
      ),
    );
  }

  /// Navigation
  Route _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/movie_details':
        return _buildRoute(settings, MovieDetailsPage(settings.arguments));
      default:
        return _buildRoute(settings, HomePage());
    }
  }

  // Build route
  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
