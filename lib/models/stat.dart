import 'dart:convert';

import 'package:pokeapi_app/models/models.dart';

class Stat {
  Stat({
    required this.baseStat,
    required this.stat,
  });

  int baseStat;
  Species stat;

  factory Stat.fromJson(String str) => Stat.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Stat.fromMap(Map<String, dynamic> json) => Stat(
        baseStat: json["base_stat"],
        stat: Species.fromMap(json["stat"]),
      );

  Map<String, dynamic> toMap() => {
        "base_stat": baseStat,
        "stat": stat.toMap(),
      };
}
