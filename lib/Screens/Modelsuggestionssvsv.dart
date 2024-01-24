// To parse this JSON data, do
//
//     final modelsuggestionssvsv = modelsuggestionssvsvFromJson(jsonString);

import 'dart:convert';

List<Modelsuggestionssvsv> modelsuggestionssvsvFromJson(String str) => List<Modelsuggestionssvsv>.from(json.decode(str).map((x) => Modelsuggestionssvsv.fromJson(x)));

String modelsuggestionssvsvToJson(List<Modelsuggestionssvsv> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Modelsuggestionssvsv {
  int id;
  String name;

  Modelsuggestionssvsv({
    required this.id,
    required this.name,
  });

  factory Modelsuggestionssvsv.fromJson(Map<String, dynamic> json) => Modelsuggestionssvsv(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
