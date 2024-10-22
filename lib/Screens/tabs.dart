import 'package:cinemagic/Models/Motion.dart';
import 'package:cinemagic/Screens/Home.dart';
import 'package:cinemagic/Screens/Watch_Later.dart';
import 'package:flutter/material.dart';

class tab extends StatefulWidget {
  @override
  State<tab> createState() => _tabState();
}

class _tabState extends State<tab> {
  late int _activeIndex;
  late Motiontype _currentType;

  @override
  void initState() {
    super.initState();
    _activeIndex = 0;
    _currentType = Motiontype.movie;
  }

  @override
  Widget build(BuildContext context) {
    _currentType = Motiontype.movie;
    if (_activeIndex == 1) {
      _currentType = Motiontype.Show;
    }

    return Scaffold(
      body: (_activeIndex != 2) ? home(type: _currentType) : watchLater(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _activeIndex,
        onTap: (index) {
          setState(() {
            _activeIndex = index;
          });
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
          )
        ],
      ),
    );
  }
}
