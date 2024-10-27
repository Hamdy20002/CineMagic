import 'dart:convert';
import 'package:cinemagic/Models/Motion.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class watchLaterNotify extends StateNotifier<List<Motion>> {
  watchLaterNotify() : super([]) {
    loadwatchLater();
  }

  Future<void> loadwatchLater() async {
    final prefs = await SharedPreferences.getInstance();
    final String? laterString = prefs.getString('WatchLater');
    if (laterString != null) {
      List<dynamic> LaterJson = jsonDecode(laterString);
      state = LaterJson.map((json) => Motion.fromJson(json)).toList();
    }
  }

  Future<void> savewatchLater() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> LaterJson =
        state.map((motion) => motion.toJson()).toList();
    prefs.setString('WatchLater', jsonEncode(LaterJson));
  }

  bool togglewatchLaterList(Motion item) {
    if (state.contains(item)) {
      //remove
      state = state.where((show) => show.id != item.id).toList();
      savewatchLater();
      return false;
    } else {
      //add
      state = [...state, item];
      savewatchLater();
      return true;
    }
  }
}

final watchLaterProvider =
    StateNotifierProvider<watchLaterNotify, List<Motion>>(
  (ref) => watchLaterNotify(),
);
