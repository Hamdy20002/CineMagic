import 'package:cinemagic/Models/data.dart';
import 'package:cinemagic/Screens/Home.dart';
import 'package:cinemagic/Screens/Watch_Later.dart';
import 'package:cinemagic/Screens/userinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class tab extends StatefulWidget {
  const tab({super.key, required this.is_User});

  final bool is_User;

  @override
  State<tab> createState() => _tabState();
}

class _tabState extends State<tab> {
  late int _activeIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _activeIndex = 0;
    _pageController = PageController(initialPage: _activeIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> NavBarItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.movie),
        activeIcon: Icon(Icons.movie_outlined),
        label: "Movies",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.tv),
        activeIcon: Icon(Icons.live_tv_rounded),
        label: "TvShows",
      ),
    ];
    if (widget.is_User) {
      NavBarItems.addAll([
        BottomNavigationBarItem(
          icon: Icon(Icons.watch_later),
          activeIcon: Icon(Icons.watch_later_outlined),
          label: "Watch Later",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          activeIcon: Icon(Icons.account_circle_outlined),
          label: "Profile",
        ),
      ]);
    }
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _activeIndex = index;
          });
        },
        children: [
          home(type: main_types.movie),
          home(type: main_types.show),
          if (widget.is_User) watchLater(),
          if (widget.is_User) userInfo(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        iconSize: 24.sp,
        currentIndex: _activeIndex,
        onTap: (index) {
          setState(() {
            _activeIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInToLinear,
          );
        },
        items: NavBarItems,
      ),
    );
  }
}
