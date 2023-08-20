// To parse this JSON data, do
//
//     final rubricaCriterio = rubricaCriterioFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<RubricaCriterio> rubricaCriterioFromJson(String str) =>
    List<RubricaCriterio>.from(
        json.decode(str).map((x) => RubricaCriterio.fromJson(x)));

String rubricaCriterioToJson(List<RubricaCriterio> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RubricaCriterio {
  String rubrica;
  String descripcion;
  String medioEvaluacion;
  String porcRubrica;
  String criterio;
  String nomCriterio;
  String valorMax;
  String valorMin;
  String porcentajeCriterio;

  RubricaCriterio({
    required this.rubrica,
    required this.descripcion,
    required this.medioEvaluacion,
    required this.porcRubrica,
    required this.criterio,
    required this.nomCriterio,
    required this.valorMax,
    required this.valorMin,
    required this.porcentajeCriterio,
  });

  factory RubricaCriterio.fromJson(Map<String, dynamic> json) =>
      RubricaCriterio(
        rubrica: json["Rubrica"],
        descripcion: json["Descripcion"],
        medioEvaluacion: json["MedioEvaluacion"],
        porcRubrica: json["PorcRubrica"],
        criterio: json["Criterio"],
        nomCriterio: json["NomCriterio"],
        valorMax: json["Valor_max"],
        valorMin: json["Valor_min"],
        porcentajeCriterio: json["Porcentaje_criterio"],
      );

  Map<String, dynamic> toJson() => {
        "Rubrica": rubrica,
        "Descripcion": descripcion,
        "MedioEvaluacion": medioEvaluacion,
        "PorcRubrica": porcRubrica,
        "Criterio": criterio,
        "NomCriterio": nomCriterio,
        "Valor_max": valorMax,
        "Valor_min": valorMin,
        "Porcentaje_criterio": porcentajeCriterio,
      };
}
