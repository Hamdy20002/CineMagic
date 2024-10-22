import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemagic/Models/Motion.dart';
import 'package:cinemagic/WatcghLater_Provider.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key, required this.item});

  final Motion item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool _IsFav = ref.watch(watchLaterProvider).contains(item);

    return SliverAppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      expandedHeight: 300,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  item.name,
                  style: const TextStyle(
                    backgroundColor: Color.fromARGB(48, 0, 0, 0),
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(
                    Icons.date_range,
                    color: Colors.green,
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
            bool result = ref
                .watch(watchLaterProvider.notifier)
                .togglewatchLaterList(item);
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
