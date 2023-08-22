// To parse this JSON data, do
//
//     final preferencias = preferenciasFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Preferencias> preferenciasFromJson(String str) => List<Preferencias>.from(
    json.decode(str).map((x) => Preferencias.fromJson(x)));

String preferenciasToJson(List<Preferencias> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Preferencias {
  String idJurado;
  String idArea;

  Preferencias({
    required this.idJurado,
    required this.idArea,
  });

  factory Preferencias.fromJson(Map<String, dynamic> json) => Preferencias(
        idJurado: json["Id_jurado"],
        idArea: json["Id_area"],
      );

  Map<String, dynamic> toJson() => {
        "Id_jurado": idJurado,
        "Id_area": idArea,
      };
}
