// To parse this JSON data, do
//
//     final salaLider = salaLiderFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<SalaLider> salaLiderFromJson(String str) =>
    List<SalaLider>.from(json.decode(str).map((x) => SalaLider.fromJson(x)));

String salaLiderToJson(List<SalaLider> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SalaLider {
  String idSala;
  String folio;
  dynamic fecha;
  dynamic horaInicio;
  dynamic horaFinal;
  String nombreSala;
  String lugar;

  SalaLider({
    required this.idSala,
    required this.folio,
    required this.fecha,
    required this.horaInicio,
    required this.horaFinal,
    required this.nombreSala,
    required this.lugar,
  });

  factory SalaLider.fromJson(Map<String, dynamic> json) => SalaLider(
        idSala: json["Id_sala"],
        folio: json["Folio"],
        fecha: DateTime.parse(json["Fecha"]),
        horaInicio: json["Hora_inicio"],
        horaFinal: json["Hora_final"],
        nombreSala: json["Nombre_sala"],
        lugar: json["Lugar"],
      );

  Map<String, dynamic> toJson() => {
        "Id_sala": idSala,
        "Folio": folio,
        "Fecha":
            "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
        "Hora_inicio": horaInicio,
        "Hora_final": horaFinal,
        "Nombre_sala": nombreSala,
        "Lugar": lugar,
      };
}
