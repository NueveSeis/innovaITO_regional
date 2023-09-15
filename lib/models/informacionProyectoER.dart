// To parse this JSON data, do
//
//     final informacionProyectoEr = informacionProyectoErFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<InformacionProyectoEr> informacionProyectoErFromJson(String str) =>
    List<InformacionProyectoEr>.from(
        json.decode(str).map((x) => InformacionProyectoEr.fromJson(x)));

String informacionProyectoErToJson(List<InformacionProyectoEr> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InformacionProyectoEr {
  dynamic idFichaTecnica;
  dynamic nombreCorto;
  dynamic nombreProyecto;
  dynamic idArea;
  dynamic nombreCategoria;
  dynamic nombreNivel;
  dynamic video;

  InformacionProyectoEr({
    required this.idFichaTecnica,
    required this.nombreCorto,
    required this.nombreProyecto,
    required this.idArea,
    required this.nombreCategoria,
    required this.nombreNivel,
    required this.video,
  });

  factory InformacionProyectoEr.fromJson(Map<String, dynamic> json) =>
      InformacionProyectoEr(
        idFichaTecnica: json["Id_fichaTecnica"],
        nombreCorto: json["Nombre_corto"],
        nombreProyecto: json["Nombre_proyecto"],
        idArea: json["Id_area"],
        nombreCategoria: json["Nombre_categoria"],
        nombreNivel: json["Nombre_nivel"],
        video: json["video"],
      );

  Map<String, dynamic> toJson() => {
        "Id_fichaTecnica": idFichaTecnica,
        "Nombre_corto": nombreCorto,
        "Nombre_proyecto": nombreProyecto,
        "Id_area": idArea,
        "Nombre_categoria": nombreCategoria,
        "Nombre_nivel": nombreNivel,
        "video": video,
      };
}
