import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/city.dart';
import '../models/clime.dart';

class MapDataService {
  static Future<List<City>> loadCities() async {
    final String response = await rootBundle.loadString('assets/data/cities.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => City.fromJson(json)).toList();
  }

  static Future<List<Clime>> loadClimes() async {
    final String response = await rootBundle.loadString('assets/data/climes.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Clime.fromJson(json)).toList();
  }
}