// To parse this JSON data, do
//
//     final datosUsuariosLogin = datosUsuariosLoginFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<DatosUsuariosLogin> datosUsuariosLoginFromJson(String str) =>
    List<DatosUsuariosLogin>.from(
        json.decode(str).map((x) => DatosUsuariosLogin.fromJson(x)));

String datosUsuariosLoginToJson(List<DatosUsuariosLogin> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DatosUsuariosLogin {
  String idUsuario;
  String nombreUsuario;
  String contrasena;
  String idRol;
  String nombreRol;
  String descripcionRol;
  String nombrePersona;
  String apellido1;
  dynamic apellido2;
  dynamic telefono;
  String correoElectronico;
  dynamic numIne;
  dynamic curp;

  DatosUsuariosLogin({
    required this.idUsuario,
    required this.nombreUsuario,
    required this.contrasena,
    required this.idRol,
    required this.nombreRol,
    required this.descripcionRol,
    required this.nombrePersona,
    required this.apellido1,
    required this.apellido2,
    required this.telefono,
    required this.correoElectronico,
    required this.numIne,
    required this.curp,
  });

  factory DatosUsuariosLogin.fromJson(Map<String, dynamic> json) =>
      DatosUsuariosLogin(
        idUsuario: json["Id_usuario"],
        nombreUsuario: json["Nombre_usuario"],
        contrasena: json["Contrasena"],
        idRol: json["Id_rol"],
        nombreRol: json["Nombre_rol"],
        descripcionRol: json["Descripcion_rol"],
        nombrePersona: json["Nombre_persona"],
        apellido1: json["Apellido1"],
        apellido2: json["Apellido2"],
        telefono: json["Telefono"],
        correoElectronico: json["Correo_electronico"],
        numIne: json["Num_ine"],
        curp: json["Curp"],
      );

  Map<String, dynamic> toJson() => {
        "Id_usuario": idUsuario,
        "Nombre_usuario": nombreUsuario,
        "Contrasena": contrasena,
        "Id_rol": idRol,
        "Nombre_rol": nombreRol,
        "Descripcion_rol": descripcionRol,
        "Nombre_persona": nombrePersona,
        "Apellido1": apellido1,
        "Apellido2": apellido2,
        "Telefono": telefono,
        "Correo_electronico": correoElectronico,
        "Num_ine": numIne,
        "Curp": curp,
      };
}
