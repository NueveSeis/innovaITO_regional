// To parse this JSON data, do
//
//     final tecnologico = tecnologicoFromJson(jsonString);

import 'dart:convert';

List<Tecnologico> tecnologicoFromJson(String str) => List<Tecnologico>.from(
    json.decode(str).map((x) => Tecnologico.fromJson(x)));

String tecnologicoToJson(List<Tecnologico> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tecnologico {
  String claveTecnologico;
  String nombreTecnologico;
  String correoElectronico;
  String idRegion;
  String idEstado;

  Tecnologico({
    required this.claveTecnologico,
    required this.nombreTecnologico,
    required this.correoElectronico,
    required this.idRegion,
    required this.idEstado,
  });

  factory Tecnologico.fromJson(Map<String, dynamic> json) => Tecnologico(
        claveTecnologico: json["Clave_tecnologico"],
        nombreTecnologico: json["Nombre_tecnologico"],
        correoElectronico: json["Correo_electronico"],
        idRegion: json["Id_region"],
        idEstado: json["Id_estado"],
      );

  Map<String, dynamic> toJson() => {
        "Clave_tecnologico": claveTecnologico,
        "Nombre_tecnologico": nombreTecnologico,
        "Correo_electronico": correoElectronico,
        "Id_region": idRegion,
        "Id_estado": idEstado,
      };
}
