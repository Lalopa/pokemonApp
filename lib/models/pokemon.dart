import 'dart:convert';

class Pokemon {
  Pokemon({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory Pokemon.fromJson(String str) => Pokemon.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pokemon.fromMap(Map<String, dynamic> json) => Pokemon(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
      };
}
