// To parse this JSON data, do
//
//     final pokemonInfoResponse = pokemonInfoResponseFromMap(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
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
  }) {
    switch (types[0].type.name) {
      case "grass":
        {
          color = const Color.fromARGB(250, 176, 242, 194);
          tipoPokemon = 'hierba';
        }
        break;
      case "fire":
        {
          color = const Color.fromARGB(250, 250, 191, 183);
          tipoPokemon = 'fuego';
        }
        break;
      case "water":
        {
          color = const Color.fromARGB(250, 178, 226, 242);
          tipoPokemon = 'agua';
        }
        break;
      case "bug":
        {
          color = const Color.fromARGB(250, 216, 248, 225);
          tipoPokemon = 'insecto';
        }
        break;
      case "normal":
        {
          color = const Color.fromARGB(250, 197, 198, 200);
          tipoPokemon = 'normal';
        }
        break;
      case "poison":
        {
          color = const Color.fromARGB(250, 211, 188, 246);
          tipoPokemon = 'veneno';
        }
        break;
      case "electric":
        {
          color = const Color.fromARGB(250, 244, 250, 180);
          tipoPokemon = 'electrico';
        }
        break;
      case "ground":
        {
          color = const Color.fromARGB(250, 236, 214, 192);
          tipoPokemon = 'tierra';
        }
        break;
      case "fairy":
        {
          color = const Color.fromARGB(250, 255, 228, 225);
          tipoPokemon = 'hada';
        }
        break;
      case "fighting":
        {
          color = const Color.fromARGB(250, 210, 190, 173);
          tipoPokemon = 'peleador';
        }
        break;
      case "psychic":
        {
          color = const Color.fromARGB(250, 235, 156, 255);
          tipoPokemon = 'psiquico';
        }
        break;
      case "rock":
        {
          color = const Color.fromARGB(250, 155, 155, 155);
          tipoPokemon = 'roca';
        }
        break;
      case "ghost":
        {
          color = const Color.fromARGB(250, 240, 162, 246);
          tipoPokemon = 'fantasma';
        }
        break;
      case "ice":
        {
          color = const Color.fromARGB(250, 117, 249, 242);
          tipoPokemon = 'hielo';
        }
        break;
      case "dragon":
        {
          color = const Color.fromARGB(250, 252, 252, 218);
          tipoPokemon = 'dragon';
        }
        break;
      default:
        {
          color = Colors.transparent;
          tipoPokemon = 'no datos';
        }
        break;
    }
  }
  String? tipoPokemon;
  int id;
  String name;
  int order;
  Color? color;
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
