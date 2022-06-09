// To parse this JSON data, do
//
//     final pokemonInfoResponse = pokemonInfoResponseFromMap(jsonString);

import 'dart:convert';

import 'package:pokeapi_app/models/models.dart';

class PokemonInfoResponse {
  PokemonInfoResponse({
    required this.id,
    required this.name,
    required this.order,
    required this.species,
    required this.sprites,
    required this.stats,
    required this.types,
  });

  int id;
  String name;
  int order;
  Species species;
  Sprites sprites;
  List<Stat> stats;
  List<Type> types;

  factory PokemonInfoResponse.fromJson(String str) =>
      PokemonInfoResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PokemonInfoResponse.fromMap(Map<String, dynamic> json) =>
      PokemonInfoResponse(
        id: json["id"],
        name: json["name"],
        order: json["order"],
        species: Species.fromMap(json["species"]),
        sprites: Sprites.fromMap(json["sprites"]),
        stats: List<Stat>.from(json["stats"].map((x) => Stat.fromMap(x))),
        types: List<Type>.from(json["types"].map((x) => Type.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "order": order,
        "species": species.toMap(),
        "sprites": sprites.toMap(),
        "stats": List<dynamic>.from(stats.map((x) => x.toMap())),
        "types": List<dynamic>.from(types.map((x) => x.toMap())),
      };
}
