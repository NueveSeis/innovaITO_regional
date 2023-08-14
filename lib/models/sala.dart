// To parse this JSON data, do
//
//     final sala = salaFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Sala> salaFromJson(String str) =>
    List<Sala>.from(json.decode(str).map((x) => Sala.fromJson(x)));

String salaToJson(List<Sala> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sala {
  String idSala;
  String nombreSala;
  String lugar;

  Sala({
    required this.idSala,
    required this.nombreSala,
    required this.lugar,
  });

  factory Sala.fromJson(Map<String, dynamic> json) => Sala(
        idSala: json["Id_sala"],
        nombreSala: json["Nombre_sala"],
        lugar: json["Lugar"],
      );

  Map<String, dynamic> toJson() => {
        "Id_sala": idSala,
        "Nombre_sala": nombreSala,
        "Lugar": lugar,
      };
}
