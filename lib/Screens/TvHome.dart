import 'package:cinemagic/Models/Tv.dart';
import 'package:cinemagic/Screens/TopRatedview.dart';
import 'package:cinemagic/Widgets/smallSlider.dart';
import 'package:flutter/material.dart';
import 'package:cinemagic/Api.dart';

import 'package:cinemagic/Widgets/HomeImageSlider.dart';

class Tvhome extends StatefulWidget {
  @override
  State<Tvhome> createState() => _TvhomeState();
}

class _TvhomeState extends State<Tvhome> {
  List<Tv> topRated = [];
  List<Tv> onAir = [];
  bool _isLoading1 = true;
  bool _isLoading2 = true;
  String error = "";

  void _loadTopRatedShow() async {
    try {
      var result = await tmdb.v3.tv.getTopRated();
      setState(() {
        result["results"]
            .take(10)
            .map(
              (show) => topRated.add(
                convertShowData(show),
              ),
            )
            .toList();
        _isLoading1 = false;
      });
    } catch (err) {
      setState(
        () {
          error = "No Internet Connection, Please Try Again Later";
        },
      );
    }
  }

  void _loadOnAirShow() async {
    try {
      var result = await tmdb.v3.tv.getOnTheAir();
      print("onAir: $result");
      setState(() {
        result["results"]
            .take(10)
            .map(
              (show) => onAir.add(
                convertShowData(show),
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
    _loadOnAirShow();
    _loadTopRatedShow();
  }

  @override
  Widget build(BuildContext context) {
    return (_isLoading1 || _isLoading2)
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            children: [
              Imageslider(
                items: onAir,
                type: "Tv",
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
                                builder: (ctx) => const viewer(type: "Tv"),
                              ),
                            );
                          },
                          child: const Text("View All"),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Smallslider(MovieList: topRated, type: "TV"),
                  ],
                ),
              ),
            ],
          );
  }
}
