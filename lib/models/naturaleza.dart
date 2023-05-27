// To parse this JSON data, do
//
//     final naturaleza = naturalezaFromJson(jsonString);

import 'dart:convert';

List<Naturaleza> naturalezaFromJson(String str) =>
    List<Naturaleza>.from(json.decode(str).map((x) => Naturaleza.fromJson(x)));

String naturalezaToJson(List<Naturaleza> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Naturaleza {
  String idNaturalezaTecnica;
  String tipo;

  Naturaleza({
    required this.idNaturalezaTecnica,
    required this.tipo,
  });

  factory Naturaleza.fromJson(Map<String, dynamic> json) => Naturaleza(
        idNaturalezaTecnica: json["Id_naturalezaTecnica"],
        tipo: json["Tipo"],
      );

  Map<String, dynamic> toJson() => {
        "Id_naturalezaTecnica": idNaturalezaTecnica,
        "Tipo": tipo,
      };
}
