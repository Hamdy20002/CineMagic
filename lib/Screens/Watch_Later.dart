import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemagic/Models/Motion.dart';
import 'package:cinemagic/WatcghLater_Provider.dart';
import 'package:cinemagic/Widgets/Reg_Slider.dart';

class watchLater extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Motion> Data = ref.watch(watchLaterProvider);
    List<Motion> Later_TvShows =
        Data.where((motion) => motion.type == Motiontype.Show).toList();
    List<Motion> Later_Movies =
        Data.where((motion) => motion.type == Motiontype.movie).toList();

    return (Later_Movies.isEmpty && Later_TvShows.isEmpty)
        ? const Center(
            child: Text("Hmm...\nTry Adding SomeThing"),
          )
        : ListView(
            children: [
              if (Later_TvShows.isNotEmpty)
                regSlider(items: Later_TvShows, title: "TvShows"),
              const SizedBox(height: 10),
              if (Later_Movies.isNotEmpty)
                regSlider(items: Later_Movies, title: "Movies"),
            ],
          );
  }
}
