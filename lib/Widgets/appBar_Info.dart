import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cinemagic/Models/Motion.dart';
import 'package:cinemagic/WatcghLater_Provider.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key, required this.item});

  final Motion item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool IsFav = ref.watch(watchLaterProvider).contains(item);

    return SliverAppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      expandedHeight: 300.h,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 200.w,
                child: Text(
                  item.name,
                  style: TextStyle(
                    backgroundColor: Color.fromARGB(50, 0, 0, 0),
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Icon(
                    Icons.date_range,
                    color: Colors.green,
                    size: 17.sp,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    item.release,
                    style: TextStyle(
                      backgroundColor: Color.fromARGB(50, 0, 0, 0),
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 17.sp,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    item.rate,
                    style: TextStyle(
                      backgroundColor: Color.fromARGB(50, 0, 0, 0),
                      color: Colors.white,
                      fontSize: 10.sp,
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
              key: ValueKey(IsFav),
              (IsFav) ? Icons.watch_later : Icons.watch_later_outlined,
            ),
          ),
        ),
      ],
    );
  }
}
