// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromMap(jsonString);

import 'dart:convert';

import 'package:pokeapi_app/models/models.dart';

class SearchResponse {
  SearchResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  int count;
  String next;
  dynamic previous;
  List<Pokemon> results;

  factory SearchResponse.fromJson(String str) =>
      SearchResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SearchResponse.fromMap(Map<String, dynamic> json) => SearchResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Pokemon>.from(json["results"].map((x) => Pokemon.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
      };
}
