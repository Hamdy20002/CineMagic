import 'package:cinemagic/Api.dart';
import 'package:cinemagic/Models/Tv.dart';
import 'package:cinemagic/Models/actor.dart';
import 'package:cinemagic/Widgets/smallSlider.dart';
import 'package:flutter/material.dart';

import 'package:cinemagic/Models/movie.dart';
import 'package:cinemagic/Widgets/MovieAppBar.dart';

class Movieinfo extends StatefulWidget {
  const Movieinfo({super.key, required this.item, required this.type});

  final dynamic item;
  final String type;

  @override
  State<Movieinfo> createState() => _MovieinfoState();
}

class _MovieinfoState extends State<Movieinfo> {
  List<Actor> cast = [];
  List<dynamic> similar = [];
  bool _isLoading1 = true;
  bool _isLoading2 = true;

  void _getcast(int id) async {
    var result = (widget.type == "Movie")
        ? await tmdb.v3.movies.getCredits(id)
        : await tmdb.v3.tv.getCredits(id);
    setState(() {
      result['cast']
          .map(
            (Actor) => cast.add(convertActor(Actor)),
          )
          .toList();
      _isLoading1 = false;
    });
  }

  void _getsimilar(int id) async {
    var result = (widget.type == "Movie")
        ? await tmdb.v3.movies.getSimilar(id)
        : await tmdb.v3.tv.getSimilar(id);
    setState(() {
      if (widget.type == "Movie") {
        result['results']
            .map(
              (movie) => similar.add(convertData(movie)),
            )
            .toList();
      } else {
        result['results']
            .map(
              (show) => similar.add(convertShowData(show)),
            )
            .toList();
      }
      _isLoading2 = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getcast(widget.item.id);
    _getsimilar(widget.item.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_isLoading1 && _isLoading2)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: [
                Movieappbar(
                  item: widget.item,
                  type: widget.type,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Overview:",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                widget.item.overview,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            if (cast.isNotEmpty) const SizedBox(height: 10),
                            Smallslider(ActorList: cast, type: "Actor"),
                            if (similar.isNotEmpty) const SizedBox(height: 10),
                            Smallslider(MovieList: similar, type: "Movie"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
