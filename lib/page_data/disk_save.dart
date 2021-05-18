import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'favourite_graphs.dart';

class DiskSave {
  static void saveToDisk(FavouriteGraphs favouriteGraphs) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('favouriteGraphs', jsonEncode(favouriteGraphs));
  }

  static Future<FavouriteGraphs> loadFromDisk() async {
    final prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> favouriteGraphsMap = {};
    final String? favouriteGraphsStr = prefs.getString('favouriteGraphs');
    if (favouriteGraphsStr != null) {
      favouriteGraphsMap =
          jsonDecode(favouriteGraphsStr) as Map<String, dynamic>;
    }

    if (favouriteGraphsMap.length > 0) {
      final FavouriteGraphs favouriteGraphs =
          FavouriteGraphs.fromJson(favouriteGraphsMap);
      print(favouriteGraphs);
      return favouriteGraphs;
    }
    return new FavouriteGraphs();
  }
}
