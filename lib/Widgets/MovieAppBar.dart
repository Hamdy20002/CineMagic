import 'package:cinemagic/Provider/FavProv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Movieappbar extends ConsumerWidget {
  const Movieappbar({super.key, required this.item, required this.type});

  final dynamic item;
  final String type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool _IsFav = (type == "Movie")
        ? ref.watch(MovieFavouriteProvider).contains(item)
        : ref.watch(TvFavouriteProvider).contains(item);

    return SliverAppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      expandedHeight: 300,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Padding(
            padding: const EdgeInsets.only(right: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    backgroundColor: Color.fromARGB(48, 0, 0, 0),
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.date_range,
                      color: Color.fromARGB(255, 0, 140, 255),
                      size: 17,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      item.release,
                      style: const TextStyle(
                        backgroundColor: Color.fromARGB(48, 0, 0, 0),
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 17,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      item.rate,
                      style: const TextStyle(
                        backgroundColor: Color.fromARGB(48, 0, 0, 0),
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        background: Hero(
          tag: item.id,
          child: Image.network(
            item.background,
            color: Theme.of(context).colorScheme.surface.withOpacity(0.3),
            colorBlendMode: BlendMode.darken,
            fit: BoxFit.cover,
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            bool result = (type == "Movie")
                ? ref
                    .watch(MovieFavouriteProvider.notifier)
                    .toggleFavoritesList(item)
                : ref
                    .watch(TvFavouriteProvider.notifier)
                    .toggleFavoritesList(item);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  (result)
                      ? "Added To Watch Later"
                      : "Removed From Watch Later",
                ),
              ),
            );
          },
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            child: Icon(
              key: ValueKey(_IsFav),
              (_IsFav) ? Icons.watch_later : Icons.watch_later_outlined,
            ),
          ),
        ),
      ],
    );
  }
}
