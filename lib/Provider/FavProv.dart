import 'dart:convert';

import 'package:cinemagic/Models/Tv.dart';
import 'package:cinemagic/Models/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TVFavouritesNotify extends StateNotifier<List<Tv>> {
  TVFavouritesNotify() : super([]) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favsString = prefs.getString('tvFavorites');
    if (favsString != null) {
      List<dynamic> favsJson = jsonDecode(favsString);
      state = favsJson.map((json) => Tv.fromJson(json)).toList();
    }
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> favsJson =
        state.map((tv) => tv.toJson()).toList();
    prefs.setString('tvFavorites', jsonEncode(favsJson));
  }

  bool toggleFavoritesList(Tv item) {
    if (state.contains(item)) {
      //remove
      state = state.where((show) => show.id != item.id).toList();
      saveFavorites();
      return false;
    } else {
      //add
      state = [...state, item];
      saveFavorites();
      return true;
    }
  }
}

final TvFavouriteProvider = StateNotifierProvider<TVFavouritesNotify, List<Tv>>(
  (ref) => TVFavouritesNotify(),
);

class MovieFavouritesNotify extends StateNotifier<List<Movie>> {
  MovieFavouritesNotify() : super([]) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favsString = prefs.getString('movieFavorites');
    if (favsString != null) {
      List<dynamic> favsJson = jsonDecode(favsString);
      state = favsJson.map((json) => Movie.fromJson(json)).toList();
    }
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> favsJson =
        state.map((movie) => movie.toJson()).toList();
    prefs.setString('movieFavorites', jsonEncode(favsJson));
  }

  bool toggleFavoritesList(Movie item) {
    if (state.contains(item)) {
      //remove
      state = state.where((movie) => movie.id != item.id).toList();
      saveFavorites();
      return false;
    } else {
      //add
      state = [...state, item];
      saveFavorites();
      return true;
    }
  }
}

final MovieFavouriteProvider =
    StateNotifierProvider<MovieFavouritesNotify, List<Movie>>(
  (ref) => MovieFavouritesNotify(),
);
