import 'package:cinemagic/Screens/Fav.dart';
import 'package:cinemagic/Screens/MovieHome.dart';
import 'package:cinemagic/Screens/TvHome.dart';
import 'package:flutter/material.dart';

class tab extends StatefulWidget {
  @override
  State<tab> createState() => _tabState();
}

class _tabState extends State<tab> {
  int _Activeindex = 0;
  String CurrentScreen = "Movie";

  void _onTapAction(int index) {
    setState(() {
      _Activeindex = index;
      if (index == 0) {
        CurrentScreen = "Movie";
      } else if (index == 1) {
        CurrentScreen = "Tv";
      } else {
        CurrentScreen = "Fav";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (CurrentScreen == "Movie")
          ? Moviehome()
          : (CurrentScreen == "Tv")
              ? Tvhome()
              : Fav(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _Activeindex,
        onTap: _onTapAction,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: "Movies",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: "Tv",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later_outlined),
            label: "Later",
          )
        ],
      ),
    );
  }
}
