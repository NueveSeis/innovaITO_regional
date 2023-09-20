// To parse this JSON data, do
//
//     final infoConstanciaTodos = infoConstanciaTodosFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<InfoConstanciaTodos> infoConstanciaTodosFromJson(String str) =>
    List<InfoConstanciaTodos>.from(
        json.decode(str).map((x) => InfoConstanciaTodos.fromJson(x)));

String infoConstanciaTodosToJson(List<InfoConstanciaTodos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InfoConstanciaTodos {
  String idFichaTecnica;
  String nombreCorto;
  String nombreProyecto;
  String nombreCategoria;
  String nombrePersona;
  String apellido1;
  String apellido2;

  InfoConstanciaTodos({
    required this.idFichaTecnica,
    required this.nombreCorto,
    required this.nombreProyecto,
    required this.nombreCategoria,
    required this.nombrePersona,
    required this.apellido1,
    required this.apellido2,
  });

  factory InfoConstanciaTodos.fromJson(Map<String, dynamic> json) =>
      InfoConstanciaTodos(
        idFichaTecnica: json["Id_fichaTecnica"],
        nombreCorto: json["Nombre_corto"],
        nombreProyecto: json["Nombre_proyecto"],
        nombreCategoria: json["Nombre_categoria"],
        nombrePersona: json["Nombre_persona"],
        apellido1: json["Apellido1"],
        apellido2: json["Apellido2"],
      );

  Map<String, dynamic> toJson() => {
        "Id_fichaTecnica": idFichaTecnica,
        "Nombre_corto": nombreCorto,
        "Nombre_proyecto": nombreProyecto,
        "Nombre_categoria": nombreCategoria,
        "Nombre_persona": nombrePersona,
        "Apellido1": apellido1,
        "Apellido2": apellido2,
      };
}
