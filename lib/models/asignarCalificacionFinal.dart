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
  String sala;
  String stand;
  String puntajeTotal;

  AsignarCalificacionFinal({
    required this.folio,
    required this.sala,
    required this.stand,
    required this.puntajeTotal,
  });

  factory AsignarCalificacionFinal.fromJson(Map<String, dynamic> json) =>
      AsignarCalificacionFinal(
        folio: json["Folio"],
        sala: json["SALA"],
        stand: json["STAND"],
        puntajeTotal: json["Puntaje_total"],
      );

  Map<String, dynamic> toJson() => {
        "Folio": folio,
        "SALA": sala,
        "STAND": stand,
        "Puntaje_total": puntajeTotal,
      };
}
