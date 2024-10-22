import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemagic/Api.dart';
import 'package:cinemagic/Models/Motion.dart';
import 'package:cinemagic/Widgets/Carousels_Slider.dart';
import 'package:cinemagic/Widgets/Reg_Slider.dart';

class home extends ConsumerStatefulWidget {
  const home({super.key, required this.type});

  final Motiontype type;

  @override
  _MoviehomeState createState() => _MoviehomeState();
}

class _MoviehomeState extends ConsumerState<home> {
  List<Motion> nowPlay = [];
  late bool _isNowPlayLoading;

  List<Motion> topRated = [];
  late bool _isTopRatedLoading;

  List<Motion> popular = [];
  late bool _isPoularLoading;

  String error = "";
  late String typeText;

  void _loadNowPlaying(Motiontype type) async {
    try {
      var result = (type == Motiontype.movie)
          ? await tmdb.v3.movies.getNowPlaying()
          : await tmdb.v3.tv.getOnTheAir();

      setState(() {
        result["results"]
            .take(10)
            .map(
              (motion) => nowPlay.add(
                converter(motion, type),
              ),
            )
            .toList();
        _isNowPlayLoading = false;
      });
    } catch (err) {
      setState(() {
        error = "No Internet Connection, Please Try Again Later";
        _isNowPlayLoading = false;
      });
    }
  }

  void _loadTopMovies(Motiontype type) async {
    try {
      var result = (type == Motiontype.movie)
          ? await tmdb.v3.movies.getTopRated()
          : await tmdb.v3.tv.getTopRated();

      setState(() {
        result["results"]
            .take(10)
            .map(
              (motion) => topRated.add(
                converter(motion, type),
              ),
            )
            .toList();
        _isTopRatedLoading = false;
      });
    } catch (err) {
      setState(() {
        error = "No Internet Connection, Please Try Again Later";
        _isTopRatedLoading = false;
      });
    }
  }

  void _loadPopular(Motiontype type) async {
    try {
      var result = (type == Motiontype.movie)
          ? await tmdb.v3.movies.getPopular()
          : await tmdb.v3.tv.getPopular();

      setState(() {
        result["results"]
            .take(10)
            .map(
              (motion) => popular.add(
                converter(motion, type),
              ),
            )
            .toList();
        _isPoularLoading = false;
      });
    } catch (err) {
      setState(() {
        error = "No Internet Connection, Please Try Again Later";
        _isPoularLoading = false;
      });
    }
  }

  void _handleData() {
    setState(() {
      nowPlay.clear();
      topRated.clear();
      popular.clear();
      _isNowPlayLoading = true;
      _isTopRatedLoading = true;
      _isPoularLoading = true;
      error = "";
    });

    typeText = (widget.type == Motiontype.movie) ? "Movies" : "Shows";
    _loadNowPlaying(widget.type);
    _loadTopMovies(widget.type);
    _loadPopular(widget.type);
  }

  @override
  void initState() {
    super.initState();
    _handleData();
  }

  @override
  void didUpdateWidget(covariant home oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.type != oldWidget.type) {
      _handleData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return (_isNowPlayLoading && _isTopRatedLoading && _isPoularLoading)
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : (error != "")
            ? Center(
                child: Text(error),
              )
            : ListView(
                children: [
                  carouselsSlider(
                    items: nowPlay,
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        regSlider(
                          items: topRated,
                          title: "Top Rated $typeText",
                        ),
                        const SizedBox(height: 10),
                        regSlider(
                          items: popular,
                          title: "Popular $typeText",
                        ),
                      ],
                    ),
                  ),
                ],
              );
  }
}
