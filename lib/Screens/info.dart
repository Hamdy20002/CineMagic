import 'package:cinemagic/Models/data.dart';
import 'package:cinemagic/Widgets/appBar_Info.dart';
import 'package:cinemagic/Widgets/Reg_Slider.dart';
import 'package:flutter/material.dart';

import 'package:cinemagic/Api.dart';
import 'package:cinemagic/Models/Motion.dart';
import 'package:cinemagic/Models/Actor.dart';

class motionInfo extends StatefulWidget {
  const motionInfo({super.key, required this.item});

  final Motion item;

  @override
  State<motionInfo> createState() => _MovieinfoState();
}

class _MovieinfoState extends State<motionInfo> {
  List<Actor> cast = [];
  bool _isCastLoading = true;

  List<Motion> similar = [];
  bool _isSimilarLoading = true;

  String error = "";

  void _getcast(int id) async {
    try {
      main_types idType = widget.item.type;
      var result = (idType == main_types.movie)
          ? await tmdb.v3.movies.getCredits(id)
          : await tmdb.v3.tv.getCredits(id);
      setState(() {
        result['cast']
            .map(
              (actor) => cast.add(
                actorConverter(actor),
              ),
            )
            .toList();
        _isSimilarLoading = false;
      });
    } catch (err) {
      error = "No Internet Connection, Please Try Again Later";
    }
  }

  void _getsimilar(int id) async {
    try {
      main_types idType = widget.item.type;
      var result = (idType == main_types.movie)
          ? await tmdb.v3.movies.getSimilar(id)
          : await tmdb.v3.tv.getSimilar(id);
      setState(() {
        result['results']
            .map(
              (motion) => similar.add(
                converter(motion, idType),
              ),
            )
            .toList();
        _isCastLoading = false;
      });
    } catch (err) {
      error = "No Internet Connection, Please Try Again Later";
    }
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
      body: (_isCastLoading && _isSimilarLoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: [
                CustomAppBar(
                  item: widget.item,
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
                            regSlider(
                              items: cast,
                              title: "Cast :",
                              type: main_types.actor,
                            ),
                            if (similar.isNotEmpty) const SizedBox(height: 10),
                            regSlider(
                              items: similar,
                              title: "Similar :",
                              type: widget.item.type,
                            ),
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
