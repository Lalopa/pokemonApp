import 'dart:convert';

class DreamWorld {
  DreamWorld({
    required this.frontDefault,
    this.frontFemale,
  });

  String frontDefault;
  dynamic frontFemale;

  factory DreamWorld.fromJson(String str) =>
      DreamWorld.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DreamWorld.fromMap(Map<String, dynamic> json) => DreamWorld(
        frontDefault: json["front_default"],
        frontFemale: json["front_female"],
      );

  Map<String, dynamic> toMap() => {
        "front_default": frontDefault,
        "front_female": frontFemale,
      };
}
