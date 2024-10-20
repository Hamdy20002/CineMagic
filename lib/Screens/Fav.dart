import 'package:cinemagic/Models/Tv.dart';
import 'package:cinemagic/Models/movie.dart';
import 'package:cinemagic/Provider/FavProv.dart';
import 'package:cinemagic/Widgets/FavItems.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Fav extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Movie> Movies = ref.watch(MovieFavouriteProvider);
    List<Tv> TvShows = ref.watch(TvFavouriteProvider);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: (Movies.isEmpty && TvShows.isEmpty)
            ? const Center(
                child: Text("You don't want to Watch-Later Anything :("),
              )
            : Column(
                children: [
                  if (Movies.isNotEmpty) Favitems(type: "Movie", items: Movies),
                  const SizedBox(height: 20),
                  if (TvShows.isNotEmpty) Favitems(type: "Tv", items: TvShows),
                ],
              ),
      ),
    );
  }
}
