// To parse this JSON data, do
//
//     final standLider = standLiderFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<StandLider> standLiderFromJson(String str) =>
    List<StandLider>.from(json.decode(str).map((x) => StandLider.fromJson(x)));

String standLiderToJson(List<StandLider> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StandLider {
  String idStand;
  String folio;
  DateTime fecha;
  String horaInicio;
  String horaFinal;
  String lugar;

  StandLider({
    required this.idStand,
    required this.folio,
    required this.fecha,
    required this.horaInicio,
    required this.horaFinal,
    required this.lugar,
  });

  factory StandLider.fromJson(Map<String, dynamic> json) => StandLider(
        idStand: json["Id_stand"],
        folio: json["Folio"],
        fecha: DateTime.parse(json["Fecha"]),
        horaInicio: json["Hora_inicio"],
        horaFinal: json["Hora_final"],
        lugar: json["Lugar"],
      );

  Map<String, dynamic> toJson() => {
        "Id_stand": idStand,
        "Folio": folio,
        "Fecha":
            "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
        "Hora_inicio": horaInicio,
        "Hora_final": horaFinal,
        "Lugar": lugar,
      };
}
