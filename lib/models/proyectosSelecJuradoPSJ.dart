// To parse this JSON data, do
//
//     final proyectosSelecJuradoPsj = proyectosSelecJuradoPsjFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ProyectosSelecJuradoPsj> proyectosSelecJuradoPsjFromJson(String str) =>
    List<ProyectosSelecJuradoPsj>.from(
        json.decode(str).map((x) => ProyectosSelecJuradoPsj.fromJson(x)));

String proyectosSelecJuradoPsjToJson(List<ProyectosSelecJuradoPsj> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProyectosSelecJuradoPsj {
  String folio;
  String idFichaTecnica;
  String nombreCorto;
  String nombreProyecto;
  String objetivo;
  String descripcionGeneral;
  String prospectoResultados;
  String idNaturalezaTecnica;
  String idArea;
  String nombreArea;
  String idCategoria;
  String nombreCategoria;
  String tipo;
  dynamic idSala;
  dynamic nombreSala;
  dynamic lugarSala;
  dynamic idStand;
  dynamic lugarStand;
  String cantidadSala;
  String cantidadStand;

  ProyectosSelecJuradoPsj({
    required this.folio,
    required this.idFichaTecnica,
    required this.nombreCorto,
    required this.nombreProyecto,
    required this.objetivo,
    required this.descripcionGeneral,
    required this.prospectoResultados,
    required this.idNaturalezaTecnica,
    required this.idArea,
    required this.nombreArea,
    required this.idCategoria,
    required this.nombreCategoria,
    required this.tipo,
    required this.idSala,
    required this.nombreSala,
    required this.lugarSala,
    required this.idStand,
    required this.lugarStand,
    required this.cantidadSala,
    required this.cantidadStand,
  });

  factory ProyectosSelecJuradoPsj.fromJson(Map<String, dynamic> json) =>
      ProyectosSelecJuradoPsj(
        folio: json["Folio"],
        idFichaTecnica: json["Id_fichaTecnica"],
        nombreCorto: json["Nombre_corto"],
        nombreProyecto: json["Nombre_proyecto"],
        objetivo: json["Objetivo"],
        descripcionGeneral: json["Descripcion_general"],
        prospectoResultados: json["Prospecto_resultados"],
        idNaturalezaTecnica: json["Id_naturalezaTecnica"],
        idArea: json["Id_area"],
        nombreArea: json["Nombre_area"],
        idCategoria: json["Id_categoria"],
        nombreCategoria: json["Nombre_categoria"],
        tipo: json["Tipo"],
        idSala: json["Id_sala"],
        nombreSala: json["Nombre_sala"],
        lugarSala: json["lugar_sala"],
        idStand: json["Id_stand"],
        lugarStand: json["Lugar_stand"],
        cantidadSala: json["cantidad_sala"],
        cantidadStand: json["cantidad_stand"],
      );

  Map<String, dynamic> toJson() => {
        "Folio": folio,
        "Id_fichaTecnica": idFichaTecnica,
        "Nombre_corto": nombreCorto,
        "Nombre_proyecto": nombreProyecto,
        "Objetivo": objetivo,
        "Descripcion_general": descripcionGeneral,
        "Prospecto_resultados": prospectoResultados,
        "Id_naturalezaTecnica": idNaturalezaTecnica,
        "Id_area": idArea,
        "Nombre_area": nombreArea,
        "Id_categoria": idCategoria,
        "Nombre_categoria": nombreCategoria,
        "Tipo": tipo,
        "Id_sala": idSala,
        "Nombre_sala": nombreSala,
        "lugar_sala": lugarSala,
        "Id_stand": idStand,
        "Lugar_stand": lugarStand,
        "cantidad_sala": cantidadSala,
        "cantidad_stand": cantidadStand,
      };
}
