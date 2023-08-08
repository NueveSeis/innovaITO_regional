// To parse this JSON data, do
//
//     final nivelAcademico = nivelAcademicoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<NivelAcademico> nivelAcademicoFromJson(String str) =>
    List<NivelAcademico>.from(
        json.decode(str).map((x) => NivelAcademico.fromJson(x)));

String nivelAcademicoToJson(List<NivelAcademico> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NivelAcademico {
  String idNivel;
  String nombreNivel;
  String descripcionNivel;

  NivelAcademico({
    required this.idNivel,
    required this.nombreNivel,
    required this.descripcionNivel,
  });

  factory NivelAcademico.fromJson(Map<String, dynamic> json) => NivelAcademico(
        idNivel: json["Id_nivel"],
        nombreNivel: json["Nombre_nivel"],
        descripcionNivel: json["Descripcion_nivel"],
      );

  Map<String, dynamic> toJson() => {
        "Id_nivel": idNivel,
        "Nombre_nivel": nombreNivel,
        "Descripcion_nivel": descripcionNivel,
      };
}
