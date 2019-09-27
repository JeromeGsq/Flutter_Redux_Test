import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:incrementally_loading_listview/incrementally_loading_listview.dart';
import 'package:redux_oab/core/widgets/loader_page.dart';
import 'package:redux_oab/modules/movie_cell/movie_cell.dart';
import 'package:redux_oab/redux/app/app_state.dart';
import 'package:redux_oab/redux/homepage/homepage_actions.dart';
import 'package:redux_oab/redux/homepage/homepage_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: StoreConnector<AppStore, HomePageState>(
          onInit: (store) => store?.dispatch(LoadHomePageMoviesAction()),
          converter: (store) => store?.state?.homePageState,
          builder: (context, homePageState) {
            return Column(
              children: <Widget>[
                Text(
                  "Next Page to load : ${homePageState.nextPageIndex.toString()}",
                ),
              ],
            );
          },
        ),
      ),
      body: StoreConnector<AppStore, HomePageState>(
        converter: (store) => store?.state?.homePageState,
        builder: (context, homePageState) {
          return homePageState?.movies?.isEmpty == true ? LoaderPage() : buildPage(homePageState, context);
        },
      ),
    );
  }

  Widget buildPage(HomePageState homePageState, BuildContext context) {
    return IncrementallyLoadingListView(
      padding: const EdgeInsets.all(8),
      hasMore: () => true,
      itemCount: () => homePageState?.movies?.length,
      loadMore: () async {
        if (!homePageState.isBusy ?? false) {
          StoreProvider.of<AppStore>(context).dispatch(
            LoadHomePageMoviesAction(
              pageIndex: homePageState?.nextPageIndex,
            ),
          );
        }
      },
      itemBuilder: (BuildContext context, int index) {
        // Is this the last item ? Replace it with CircularProgressIndicator
        if (index == homePageState.movies.length - 1) {
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
            child: HomepageMovieCell(homePageState.movies[index]),
          );
        }
      },
    );
  }
}
