// To parse this JSON data, do
//
//     final usuarioData = usuarioDataFromJson(jsonString);

import 'dart:convert';

List<UsuarioData> usuarioDataFromJson(String str) => List<UsuarioData>.from(
    json.decode(str).map((x) => UsuarioData.fromJson(x)));

String usuarioDataToJson(List<UsuarioData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsuarioData {
  String idUsuario;
  String nombreRol;
  String nombrePersona;
  String apellido1;
  String apellido2;
  String correoElectronico;

  UsuarioData({
    required this.idUsuario,
    required this.nombreRol,
    required this.nombrePersona,
    required this.apellido1,
    required this.apellido2,
    required this.correoElectronico,
  });

  factory UsuarioData.fromJson(Map<String, dynamic> json) => UsuarioData(
        idUsuario: json["Id_usuario"],
        nombreRol: json["Nombre_rol"],
        nombrePersona: json["Nombre_persona"],
        apellido1: json["Apellido1"],
        apellido2: json["Apellido2"],
        correoElectronico: json["Correo_electronico"],
      );

  Map<String, dynamic> toJson() => {
        "Id_usuario": idUsuario,
        "Nombre_rol": nombreRol,
        "Nombre_persona": nombrePersona,
        "Apellido1": apellido1,
        "Apellido2": apellido2,
        "Correo_electronico": correoElectronico,
      };
}
