// To parse this JSON data, do
//
//     final proyectoAsesorWf = proyectoAsesorWfFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ProyectoAsesorWf> proyectoAsesorWfFromJson(String str) =>
    List<ProyectoAsesorWf>.from(
        json.decode(str).map((x) => ProyectoAsesorWf.fromJson(x)));

String proyectoAsesorWfToJson(List<ProyectoAsesorWf> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProyectoAsesorWf {
  String folio;
  String idAsesor;

  ProyectoAsesorWf({
    required this.folio,
    required this.idAsesor,
  });

  factory ProyectoAsesorWf.fromJson(Map<String, dynamic> json) =>
      ProyectoAsesorWf(
        folio: json["Folio"],
        idAsesor: json["Id_asesor"],
      );

  Map<String, dynamic> toJson() => {
        "Folio": folio,
        "Id_asesor": idAsesor,
      };
}
