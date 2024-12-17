import 'package:cinemagic/Models/data.dart';
import 'package:cinemagic/Widgets/appBar_Info.dart';
import 'package:cinemagic/Widgets/Reg_Slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 20.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Overview:",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 10.h,
                              ),
                              child: Text(
                                widget.item.overview,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            if (cast.isNotEmpty)
                              regSlider(
                                items: cast,
                                title: "Cast :",
                                type: main_types.actor,
                              ),
                            SizedBox(height: 10.h),
                            if (similar.isNotEmpty)
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
