import 'dart:convert';

import 'package:pokeapi_app/models/models.dart';

//Clase para obtener la imagen del pokemon
class Sprites {
  Sprites({
    required this.frontDefault,
    required this.other,
  });

  String frontDefault;
  Other other;

  factory Sprites.fromJson(String str) => Sprites.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Sprites.fromMap(Map<String, dynamic> json) => Sprites(
        frontDefault: json["front_default"],
        other: Other.fromMap(json["other"]),
      );

  Map<String, dynamic> toMap() => {
        "front_default": frontDefault,
        "other": other.toMap(),
      };
}
