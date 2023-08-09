// To parse this JSON data, do
//
//     final region = regionFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Region> regionFromJson(String str) =>
    List<Region>.from(json.decode(str).map((x) => Region.fromJson(x)));

String regionToJson(List<Region> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Region {
  String idRegion;
  String numeroRegion;

  Region({
    required this.idRegion,
    required this.numeroRegion,
  });

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        idRegion: json["Id_region"],
        numeroRegion: json["Numero_region"],
      );

  Map<String, dynamic> toJson() => {
        "Id_region": idRegion,
        "Numero_region": numeroRegion,
      };
}
