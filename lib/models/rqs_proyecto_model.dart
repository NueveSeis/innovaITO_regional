// To parse this JSON data, do
//
//     final rqsProyecto = rqsProyectoFromJson(jsonString);

import 'dart:convert';

List<RqsProyecto> rqsProyectoFromJson(String str) => List<RqsProyecto>.from(json.decode(str).map((x) => RqsProyecto.fromJson(x)));

String rqsProyectoToJson(List<RqsProyecto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RqsProyecto {
    String idFichaTecnica;
    String nombreCorto;
    String nombreProyecto;
    String objetivo;
    String descripcionGeneral;
    String prospectoResultados;
    String idCategoria;
    String matricula;
    String idAsesor;
    String idNaturalezaTecnica;
    String idRequerimientoEspecial;

    RqsProyecto({
        required this.idFichaTecnica,
        required this.nombreCorto,
        required this.nombreProyecto,
        required this.objetivo,
        required this.descripcionGeneral,
        required this.prospectoResultados,
        required this.idCategoria,
        required this.matricula,
        required this.idAsesor,
        required this.idNaturalezaTecnica,
        required this.idRequerimientoEspecial,
    });

    factory RqsProyecto.fromJson(Map<String, dynamic> json) => RqsProyecto(
        idFichaTecnica: json["Id_fichaTecnica"],
        nombreCorto: json["Nombre_corto"],
        nombreProyecto: json["Nombre_proyecto"],
        objetivo: json["Objetivo"],
        descripcionGeneral: json["Descripcion_general"],
        prospectoResultados: json["Prospecto_resultados"],
        idCategoria: json["Id_categoria"],
        matricula: json["Matricula"],
        idAsesor: json["Id_asesor"],
        idNaturalezaTecnica: json["Id_naturalezaTecnica"],
        idRequerimientoEspecial: json["Id_requerimientoEspecial"],
    );

    Map<String, dynamic> toJson() => {
        "Id_fichaTecnica": idFichaTecnica,
        "Nombre_corto": nombreCorto,
        "Nombre_proyecto": nombreProyecto,
        "Objetivo": objetivo,
        "Descripcion_general": descripcionGeneral,
        "Prospecto_resultados": prospectoResultados,
        "Id_categoria": idCategoria,
        "Matricula": matricula,
        "Id_asesor": idAsesor,
        "Id_naturalezaTecnica": idNaturalezaTecnica,
        "Id_requerimientoEspecial": idRequerimientoEspecial,
    };
}
