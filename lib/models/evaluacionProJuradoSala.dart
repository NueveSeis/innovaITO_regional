// To parse this JSON data, do
//
//     final evaluacionProJuradoSala = evaluacionProJuradoSalaFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<EvaluacionProJuradoSala> evaluacionProJuradoSalaFromJson(String str) =>
    List<EvaluacionProJuradoSala>.from(
        json.decode(str).map((x) => EvaluacionProJuradoSala.fromJson(x)));

String evaluacionProJuradoSalaToJson(List<EvaluacionProJuradoSala> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EvaluacionProJuradoSala {
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
  String idSala;
  String nombreSala;
  String lugarSala;
  String idStand;
  String lugarStand;
  DateTime fechaSala;
  String horaInicioSala;
  String horaFinalSala;
  DateTime fechaStan;
  String horaInicioStand;
  String horaFinalStand;
  dynamic estadoEvaluacion;

  EvaluacionProJuradoSala({
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
    required this.fechaSala,
    required this.horaInicioSala,
    required this.horaFinalSala,
    required this.fechaStan,
    required this.horaInicioStand,
    required this.horaFinalStand,
    required this.estadoEvaluacion,
  });

  factory EvaluacionProJuradoSala.fromJson(Map<String, dynamic> json) =>
      EvaluacionProJuradoSala(
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
        fechaSala: DateTime.parse(json["fechaSala"]),
        horaInicioSala: json["Hora_inicio_sala"],
        horaFinalSala: json["Hora_final_sala"],
        fechaStan: DateTime.parse(json["fechaStan"]),
        horaInicioStand: json["Hora_inicio_stand"],
        horaFinalStand: json["Hora_final_stand"],
        estadoEvaluacion: json["Estado_evaluacion"],
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
        "fechaSala":
            "${fechaSala.year.toString().padLeft(4, '0')}-${fechaSala.month.toString().padLeft(2, '0')}-${fechaSala.day.toString().padLeft(2, '0')}",
        "Hora_inicio_sala": horaInicioSala,
        "Hora_final_sala": horaFinalSala,
        "fechaStan":
            "${fechaStan.year.toString().padLeft(4, '0')}-${fechaStan.month.toString().padLeft(2, '0')}-${fechaStan.day.toString().padLeft(2, '0')}",
        "Hora_inicio_stand": horaInicioStand,
        "Hora_final_stand": horaFinalStand,
        "Estado_evaluacion": estadoEvaluacion,
      };
}
