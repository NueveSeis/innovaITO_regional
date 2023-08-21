// To parse this JSON data, do
//
//     final criterioRubrica = criterioRubricaFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<CriterioRubrica> criterioRubricaFromJson(String str) =>
    List<CriterioRubrica>.from(
        json.decode(str).map((x) => CriterioRubrica.fromJson(x)));

String criterioRubricaToJson(List<CriterioRubrica> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CriterioRubrica {
  String idCriterio;
  String nombreCriterio;
  String valorMax;
  String valorMin;
  String porcentajeCriterio;
  String idRubrica;
  String descripcion;
  String medioEvaluacion;
  String porcentajeRubrica;

  CriterioRubrica({
    required this.idCriterio,
    required this.nombreCriterio,
    required this.valorMax,
    required this.valorMin,
    required this.porcentajeCriterio,
    required this.idRubrica,
    required this.descripcion,
    required this.medioEvaluacion,
    required this.porcentajeRubrica,
  });

  factory CriterioRubrica.fromJson(Map<String, dynamic> json) =>
      CriterioRubrica(
        idCriterio: json["Id_criterio"],
        nombreCriterio: json["Nombre_criterio"],
        valorMax: json["Valor_max"],
        valorMin: json["Valor_min"],
        porcentajeCriterio: json["Porcentaje_criterio"],
        idRubrica: json["Id_rubrica"],
        descripcion: json["Descripcion"],
        medioEvaluacion: json["Medio_evaluacion"],
        porcentajeRubrica: json["Porcentaje_rubrica"],
      );

  Map<String, dynamic> toJson() => {
        "Id_criterio": idCriterio,
        "Nombre_criterio": nombreCriterio,
        "Valor_max": valorMax,
        "Valor_min": valorMin,
        "Porcentaje_criterio": porcentajeCriterio,
        "Id_rubrica": idRubrica,
        "Descripcion": descripcion,
        "Medio_evaluacion": medioEvaluacion,
        "Porcentaje_rubrica": porcentajeRubrica,
      };
}
