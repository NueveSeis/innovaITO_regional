// To parse this JSON data, do
//
//     final area = areaFromJson(jsonString);

import 'dart:convert';

List<Area> areaFromJson(String str) =>
    List<Area>.from(json.decode(str).map((x) => Area.fromJson(x)));

String areaToJson(List<Area> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Area {
  String idArea;
  String nombreArea;
  String idCategoria;

  Area({
    required this.idArea,
    required this.nombreArea,
    required this.idCategoria,
  });

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        idArea: json["Id_area"],
        nombreArea: json["Nombre_area"],
        idCategoria: json["Id_categoria"],
      );

  Map<String, dynamic> toJson() => {
        "Id_area": idArea,
        "Nombre_area": nombreArea,
        "Id_categoria": idCategoria,
      };
}
