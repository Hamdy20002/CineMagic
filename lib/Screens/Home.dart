import 'package:cinemagic/Models/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemagic/Models/Motion.dart';
import 'package:cinemagic/Widgets/Carousels_Slider.dart';
import 'package:cinemagic/Widgets/Reg_Slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class home extends ConsumerStatefulWidget {
  const home({super.key, required this.type});

  final main_types type;

  @override
  _MoviehomeState createState() => _MoviehomeState();
}

class _MoviehomeState extends ConsumerState<home> {
  final Map<main_types, List<Motion>> cached_nowPlay = {};
  final Map<main_types, List<Motion>> cached_topRated = {};
  final Map<main_types, List<Motion>> cached_popular = {};

  List<Motion> nowPlay = [];
  List<Motion> topRated = [];
  List<Motion> popular = [];
  bool isLoading = false;
  String error = "";

  void _handleData() async {
    if (cached_nowPlay.containsKey(widget.type)) {
      setState(() {
        nowPlay = cached_nowPlay[widget.type]!;
        topRated = cached_topRated[widget.type]!;
        popular = cached_popular[widget.type]!;
        isLoading = false;
      });
      return;
    }

    setState(() {
      isLoading = true;
      error = "";
    });

    try {
      if (!mounted) return;
      final nowPlayData = await loadNowPlaying(widget.type);
      final topRatedData = await loadTopRated(widget.type, 1);
      final popularData = await loadPopular(widget.type, 1);

      setState(() {
        nowPlay = nowPlayData.take(5).toList();
        topRated = topRatedData.take(5).toList();
        popular = popularData.sublist(5).toList();

        cached_nowPlay[widget.type] = nowPlay;
        cached_topRated[widget.type] = topRated;
        cached_popular[widget.type] = popular;

        isLoading = false;
      });
    } catch (err) {
      if (!mounted) return;
      setState(() {
        error = err.toString();
        isLoading = false;
      });
    }
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
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : (error.isNotEmpty)
            ? Center(
                child: Text(error),
              )
            : ListView(
                children: [
                  carouselsSlider(items: nowPlay),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        regSlider(
                          items: topRated,
                          title: "Top Rated ${widget.type.name}",
                          type: widget.type,
                        ),
                        SizedBox(height: 10.h),
                        regSlider(
                          items: popular,
                          title: "Popular ${widget.type.name}",
                          type: widget.type,
                        ),
                      ],
                    ),
                  ),
                ],
              );
  }
}
