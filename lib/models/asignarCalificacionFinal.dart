// To parse this JSON data, do
//
//     final asignarCalificacionFinal = asignarCalificacionFinalFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AsignarCalificacionFinal> asignarCalificacionFinalFromJson(String str) =>
    List<AsignarCalificacionFinal>.from(
        json.decode(str).map((x) => AsignarCalificacionFinal.fromJson(x)));

String asignarCalificacionFinalToJson(List<AsignarCalificacionFinal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AsignarCalificacionFinal {
  String folio;
  String calificacionSala;
  String calificacionStand;
  String calificacionGlobal;

  AsignarCalificacionFinal({
    required this.folio,
    required this.calificacionSala,
    required this.calificacionStand,
    required this.calificacionGlobal,
  });

  factory AsignarCalificacionFinal.fromJson(Map<String, dynamic> json) =>
      AsignarCalificacionFinal(
        folio: json["Folio"],
        calificacionSala: json["Calificacion_SALA"],
        calificacionStand: json["Calificacion_STAND"],
        calificacionGlobal: json["Calificacion_global"],
      );

  Map<String, dynamic> toJson() => {
        "Folio": folio,
        "Calificacion_SALA": calificacionSala,
        "Calificacion_STAND": calificacionStand,
        "Calificacion_global": calificacionGlobal,
      };
}
