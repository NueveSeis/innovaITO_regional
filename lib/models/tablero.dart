
import 'package:meta/meta.dart';
import 'dart:convert';

List<Tablero> tableroFromJson(String str) =>
    List<Tablero>.from(json.decode(str).map((x) => Tablero.fromJson(x)));

String tableroToJson(List<Tablero> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tablero {
  String calificacionGlobal;
  String nombreCorto;
  String nombreArea;

  Tablero({
    required this.calificacionGlobal,
    required this.nombreCorto,
    required this.nombreArea,
  });

  factory Tablero.fromJson(Map<String, dynamic> json) => Tablero(
        calificacionGlobal: json["Calificacion_global"],
        nombreCorto: json["Nombre_corto"],
        nombreArea: json["Nombre_area"],
      );

  Map<String, dynamic> toJson() => {
        "Calificacion_global": calificacionGlobal,
        "Nombre_corto": nombreCorto,
        "Nombre_area": nombreArea,
      };
}
