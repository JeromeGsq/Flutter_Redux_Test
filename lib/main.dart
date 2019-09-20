import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_oab/middleware/api_middleware.dart';
import 'package:redux_oab/models/movie_result.dart';

import 'package:redux_oab/state/appstate.dart';
import 'package:incrementally_loading_listview/incrementally_loading_listview.dart';

import 'enums/actions.dart';
import 'modules/movie_cell/movie_cell.dart';

void main() {
  final store = Store<AppState>(appStoreReducer,
      initialState: AppState(false, 0, []),
      middleware: <Middleware<AppState>>[
        apiMiddleware,
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
  void initState() {
    widget.store.dispatch(LoadHomePageMoviesAction());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        theme: ThemeData.light(),
        title: widget.title,
        home: Scaffold(
          appBar: AppBar(
              title: StoreConnector<AppState, String>(
            converter: (store) =>
                "Next Page to load : ${store.state.nextPageIndex.toString()}",
            builder: (context, currentPage) {
              return Text(currentPage);
            },
          )),
          body: Center(
            child: StoreConnector<AppState, List<MovieResult>>(
              converter: (store) => store.state.homepageMovies,
              builder: (context, value) {
                return IncrementallyLoadingListView(
                  padding: const EdgeInsets.all(8),
                  hasMore: () => true,
                  itemCount: () => value.length,
                  loadMore: () async {
                    if (!widget.store.state.isBusy) {
                      widget.store.dispatch(
                        LoadHomePageMoviesAction(
                          pageIndex: widget.store.state.nextPageIndex,
                        ),
                      );
                    }
                  },
                  itemBuilder: (BuildContext context, int index) {
                    // Is this the last item ? Replace it with CircularProgressIndicator
                    if (index == value.length - 1) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 50,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: HomepageMovieCell(widget.store, value[index]),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
