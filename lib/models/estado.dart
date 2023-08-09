// To parse this JSON data, do
//
//     final estado = estadoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Estado> estadoFromJson(String str) =>
    List<Estado>.from(json.decode(str).map((x) => Estado.fromJson(x)));

String estadoToJson(List<Estado> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Estado {
  String idEstado;
  String nombreEstado;

  Estado({
    required this.idEstado,
    required this.nombreEstado,
  });

  factory Estado.fromJson(Map<String, dynamic> json) => Estado(
        idEstado: json["Id_estado"],
        nombreEstado: json["Nombre_estado"],
      );

  Map<String, dynamic> toJson() => {
        "Id_estado": idEstado,
        "Nombre_estado": nombreEstado,
      };
}
