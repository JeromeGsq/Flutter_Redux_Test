import 'package:redux_oab/models/movie.dart';
import 'package:dio/dio.dart';
import 'package:redux_oab/models/movie_result.dart';
import 'package:redux_oab/models/search_result.dart';

final String baseUrl = "http://www.omdbapi.com/?apikey=2f0063dd";

class ApiClient {
  Future<Movie> getMovie(String id) async {
    var dio = Dio(); // TODO: don't do that
    Response response = await dio.get(baseUrl + "&i=" + id);
    if (response.statusCode == 200) {
      return Movie.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<List<MovieResult>> getHomePageMovies(int pageIndex) async {
    var dio = Dio(); // TODO: don't do that
    Response response = await dio.get("${baseUrl}&s=orange&page=${pageIndex}");
    await Future.delayed(Duration(seconds: 1));

    if (response.statusCode == 200) {
      return SearchResult.fromJson(response.data).movies;
    } else {
      return null;
    }
  }
}
