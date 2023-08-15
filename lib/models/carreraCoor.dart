// To parse this JSON data, do
//
//     final carreraCoor = carreraCoorFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<CarreraCoor> carreraCoorFromJson(String str) => List<CarreraCoor>.from(
    json.decode(str).map((x) => CarreraCoor.fromJson(x)));

String carreraCoorToJson(List<CarreraCoor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CarreraCoor {
  String idCarrera;
  String nombreCarrera;
  String idNivel;
  String idDepartamento;
  String nombreDepartamento;
  String claveTecnologico;
  String nombreTecnologico;
  String correoElectronico;
  String idRegion;
  String idEstado;
  String idTipoTec;

  CarreraCoor({
    required this.idCarrera,
    required this.nombreCarrera,
    required this.idNivel,
    required this.idDepartamento,
    required this.nombreDepartamento,
    required this.claveTecnologico,
    required this.nombreTecnologico,
    required this.correoElectronico,
    required this.idRegion,
    required this.idEstado,
    required this.idTipoTec,
  });

  factory CarreraCoor.fromJson(Map<String, dynamic> json) => CarreraCoor(
        idCarrera: json["Id_carrera"],
        nombreCarrera: json["Nombre_carrera"],
        idNivel: json["Id_nivel"],
        idDepartamento: json["Id_departamento"],
        nombreDepartamento: json["Nombre_departamento"],
        claveTecnologico: json["Clave_tecnologico"],
        nombreTecnologico: json["Nombre_tecnologico"],
        correoElectronico: json["Correo_electronico"],
        idRegion: json["Id_region"],
        idEstado: json["Id_estado"],
        idTipoTec: json["Id_tipoTec"],
      );

  Map<String, dynamic> toJson() => {
        "Id_carrera": idCarrera,
        "Nombre_carrera": nombreCarrera,
        "Id_nivel": idNivel,
        "Id_departamento": idDepartamento,
        "Nombre_departamento": nombreDepartamento,
        "Clave_tecnologico": claveTecnologico,
        "Nombre_tecnologico": nombreTecnologico,
        "Correo_electronico": correoElectronico,
        "Id_region": idRegion,
        "Id_estado": idEstado,
        "Id_tipoTec": idTipoTec,
      };
}
