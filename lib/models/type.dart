import 'dart:convert';

import 'package:pokeapi_app/models/models.dart';

class Type {
  Type({
    required this.slot,
    required this.type,
  });

  int slot;
  Species type;

  factory Type.fromJson(String str) => Type.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Type.fromMap(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        type: Species.fromMap(json["type"]),
      );

  Map<String, dynamic> toMap() => {
        "slot": slot,
        "type": type.toMap(),
      };
}
