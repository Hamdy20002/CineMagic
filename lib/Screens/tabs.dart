import 'package:cinemagic/Models/data.dart';
import 'package:cinemagic/Screens/Home.dart';
import 'package:cinemagic/Screens/Watch_Later.dart';
import 'package:flutter/material.dart';

class tab extends StatefulWidget {
  const tab({super.key});

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
          watchLater(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: "Movies",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv_rounded),
            label: "TvShows",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later),
            label: "Watch Later",
          ),
        ],
      ),
    );
  }
}
