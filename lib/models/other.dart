import 'dart:convert';

import 'package:pokeapi_app/models/models.dart';

class Other {
  Other({
    required this.dreamWorld,
  });

  DreamWorld dreamWorld;

  factory Other.fromJson(String str) => Other.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Other.fromMap(Map<String, dynamic> json) => Other(
        dreamWorld: DreamWorld.fromMap(json["dream_world"]),
      );

  Map<String, dynamic> toMap() => {
        "dream_world": dreamWorld.toMap(),
      };
}
