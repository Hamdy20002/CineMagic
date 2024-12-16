import 'package:cinemagic/Models/Motion.dart';
import 'package:cinemagic/Api.dart';

enum main_types {
  movie,
  show,
  actor,
}

Future<List<Motion>> loadNowPlaying(main_types type) async {
  List<Motion> returnedItem = [];
  try {
    var result = (type == main_types.movie)
        ? await tmdb.v3.movies.getNowPlaying()
        : await tmdb.v3.tv.getOnTheAir();

    result["results"]
        .map(
          (motion) => returnedItem.add(
            converter(motion, type),
          ),
        )
        .toList();
    return returnedItem;
  } catch (err) {
    throw Exception("No Internet Connection, Please Try Again Later");
  }
}

Future<List<Motion>> loadPopular(main_types type, int page) async {
  try {
    var result = (type == main_types.movie)
        ? await tmdb.v3.movies.getPopular(page: page)
        : await tmdb.v3.tv.getPopular(page: page);

    return result["results"]
        .map<Motion>(
          (motion) => converter(motion, type),
        )
        .toList();
  } catch (err) {
    throw Exception("Failed to load data");
  }
}

Future<List<Motion>> loadTopRated(main_types type, int page) async {
  try {
    var result = (type == main_types.movie)
        ? await tmdb.v3.movies.getTopRated(page: page)
        : await tmdb.v3.tv.getTopRated(page: page);

    return result["results"]
        .map<Motion>(
          (motion) => converter(motion, type),
        )
        .toList();
  } catch (err) {
    throw Exception("Failed to load data");
  }
}
