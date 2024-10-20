import 'package:cinemagic/Screens/TopRatedview.dart';
import 'package:cinemagic/Widgets/smallSlider.dart';
import 'package:flutter/material.dart';
import 'package:cinemagic/Api.dart';

import 'package:cinemagic/Widgets/HomeImageSlider.dart';
import 'package:cinemagic/Models/movie.dart';

class Moviehome extends StatefulWidget {
  @override
  State<Moviehome> createState() => _MoviehomeState();
}

class _MoviehomeState extends State<Moviehome> {
  List<Movie> nowPlay = [];
  List<Movie> topRated = [];
  bool _isLoading1 = true;
  bool _isLoading2 = true;
  String error = "";

  void _loadNowPlayingMovies() async {
    try {
      var result = await tmdb.v3.movies.getNowPlaying();
      setState(() {
        result["results"]
            .take(10)
            .map(
              (movie) => nowPlay.add(
                convertData(movie),
              ),
            )
            .toList();
        _isLoading1 = false;
      });
    } catch (err) {
      setState(() {
        error = "No Internet Connection, Please Try Again Later";
      });
    }
  }

  void _loadTopMovies() async {
    try {
      var result = await tmdb.v3.movies.getTopRated();
      setState(() {
        result["results"]
            .take(10)
            .map(
              (movie) => topRated.add(
                convertData(movie),
              ),
            )
            .toList();
        _isLoading2 = false;
      });
    } catch (err) {
      setState(() {
        error = "No Internet Connection, Please Try Again Later";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadTopMovies();
    _loadNowPlayingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return (_isLoading1 || _isLoading2)
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : (error != "")
            ? Center(
                child: Text(error),
              )
            : ListView(
                children: [
                  Imageslider(
                    items: nowPlay,
                    type: "Movie",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Top Rated: ",
                              style: TextStyle(fontSize: 22),
                            ),
                            const Spacer(),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            const viewer(type: "Movie")),
                                  );
                                },
                                child: const Text("View All"))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Smallslider(MovieList: topRated, type: "Movie"),
                      ],
                    ),
                  ),
                ],
              );
  }
}
