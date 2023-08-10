// To parse this JSON data, do
//
//     final proyectoAsesor = proyectoAsesorFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ProyectoAsesor> proyectoAsesorFromJson(String str) =>
    List<ProyectoAsesor>.from(
        json.decode(str).map((x) => ProyectoAsesor.fromJson(x)));

String proyectoAsesorToJson(List<ProyectoAsesor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProyectoAsesor {
  String fechaValidacion;
  String observaciones;
  String estado;
  String folio;
  String calificacionGlobal;
  dynamic estadoAcreditacion;
  dynamic estadoAsistencia;
  dynamic oficioAsistencia;
  dynamic video;
  dynamic posicionActual;
  dynamic estadoEvaluacion;
  dynamic modeloNegocio;
  String planNegocio;
  dynamic idMemoriaTecnica;
  String idFichaTecnica;
  dynamic descripcionProblematica;
  dynamic estadoArte;
  dynamic descripcionInnovacion;
  dynamic propuestaValor;
  dynamic mercadoPotencial;
  dynamic imagenMercadoPotencial;
  dynamic viabilidadTecnica;
  dynamic imagenViabilidadTecnica;
  dynamic viabilidadFinanciera;
  dynamic imagenViabilidadFinanciera;
  dynamic estrategiaPropiedadIntelectual;
  dynamic imagenPropiedadIntelectual;
  dynamic interpretacionResultados;
  dynamic fuentesConsultadas;
  String nombreCorto;
  String nombreProyecto;
  String objetivo;
  String descripcionGeneral;
  String prospectoResultados;
  String idNaturalezaTecnica;
  String tipo;
  String idArea;
  String nombreArea;
  String idCategoria;
  String nombreCategoria;

  ProyectoAsesor({
    required this.fechaValidacion,
    required this.observaciones,
    required this.estado,
    required this.folio,
    required this.calificacionGlobal,
    required this.estadoAcreditacion,
    required this.estadoAsistencia,
    required this.oficioAsistencia,
    required this.video,
    required this.posicionActual,
    required this.estadoEvaluacion,
    required this.modeloNegocio,
    required this.planNegocio,
    required this.idMemoriaTecnica,
    required this.idFichaTecnica,
    required this.descripcionProblematica,
    required this.estadoArte,
    required this.descripcionInnovacion,
    required this.propuestaValor,
    required this.mercadoPotencial,
    required this.imagenMercadoPotencial,
    required this.viabilidadTecnica,
    required this.imagenViabilidadTecnica,
    required this.viabilidadFinanciera,
    required this.imagenViabilidadFinanciera,
    required this.estrategiaPropiedadIntelectual,
    required this.imagenPropiedadIntelectual,
    required this.interpretacionResultados,
    required this.fuentesConsultadas,
    required this.nombreCorto,
    required this.nombreProyecto,
    required this.objetivo,
    required this.descripcionGeneral,
    required this.prospectoResultados,
    required this.idNaturalezaTecnica,
    required this.tipo,
    required this.idArea,
    required this.nombreArea,
    required this.idCategoria,
    required this.nombreCategoria,
  });

  factory ProyectoAsesor.fromJson(Map<String, dynamic> json) => ProyectoAsesor(
        fechaValidacion: json["Fecha_validacion"],
        observaciones: json["Observaciones"],
        estado: json["Estado"],
        folio: json["Folio"],
        calificacionGlobal: json["Calificacion_global"],
        estadoAcreditacion: json["Estado_acreditacion"],
        estadoAsistencia: json["Estado_asistencia"],
        oficioAsistencia: json["Oficio_asistencia"],
        video: json["Video"],
        posicionActual: json["Posicion_actual"],
        estadoEvaluacion: json["Estado_evaluacion"],
        modeloNegocio: json["Modelo_negocio"],
        planNegocio: json["Plan_negocio"],
        idMemoriaTecnica: json["Id_memoriaTecnica"],
        idFichaTecnica: json["Id_fichaTecnica"],
        descripcionProblematica: json["Descripcion_problematica"],
        estadoArte: json["Estado_arte"],
        descripcionInnovacion: json["Descripcion_innovacion"],
        propuestaValor: json["Propuesta_valor"],
        mercadoPotencial: json["Mercado_potencial"],
        imagenMercadoPotencial: json["Imagen_mercadoPotencial"],
        viabilidadTecnica: json["Viabilidad_tecnica"],
        imagenViabilidadTecnica: json["Imagen_viabilidadTecnica"],
        viabilidadFinanciera: json["Viabilidad_financiera"],
        imagenViabilidadFinanciera: json["Imagen_viabilidadFinanciera"],
        estrategiaPropiedadIntelectual: json["Estrategia_propiedadIntelectual"],
        imagenPropiedadIntelectual: json["Imagen_propiedadIntelectual"],
        interpretacionResultados: json["Interpretacion_resultados"],
        fuentesConsultadas: json["Fuentes_consultadas"],
        nombreCorto: json["Nombre_corto"],
        nombreProyecto: json["Nombre_proyecto"],
        objetivo: json["Objetivo"],
        descripcionGeneral: json["Descripcion_general"],
        prospectoResultados: json["Prospecto_resultados"],
        idNaturalezaTecnica: json["Id_naturalezaTecnica"],
        tipo: json["Tipo"],
        idArea: json["Id_area"],
        nombreArea: json["Nombre_area"],
        idCategoria: json["Id_categoria"],
        nombreCategoria: json["Nombre_categoria"],
      );

  Map<String, dynamic> toJson() => {
        "Fecha_validacion": fechaValidacion,
        "Observaciones": observaciones,
        "Estado": estado,
        "Folio": folio,
        "Calificacion_global": calificacionGlobal,
        "Estado_acreditacion": estadoAcreditacion,
        "Estado_asistencia": estadoAsistencia,
        "Oficio_asistencia": oficioAsistencia,
        "Video": video,
        "Posicion_actual": posicionActual,
        "Estado_evaluacion": estadoEvaluacion,
        "Modelo_negocio": modeloNegocio,
        "Plan_negocio": planNegocio,
        "Id_memoriaTecnica": idMemoriaTecnica,
        "Id_fichaTecnica": idFichaTecnica,
        "Descripcion_problematica": descripcionProblematica,
        "Estado_arte": estadoArte,
        "Descripcion_innovacion": descripcionInnovacion,
        "Propuesta_valor": propuestaValor,
        "Mercado_potencial": mercadoPotencial,
        "Imagen_mercadoPotencial": imagenMercadoPotencial,
        "Viabilidad_tecnica": viabilidadTecnica,
        "Imagen_viabilidadTecnica": imagenViabilidadTecnica,
        "Viabilidad_financiera": viabilidadFinanciera,
        "Imagen_viabilidadFinanciera": imagenViabilidadFinanciera,
        "Estrategia_propiedadIntelectual": estrategiaPropiedadIntelectual,
        "Imagen_propiedadIntelectual": imagenPropiedadIntelectual,
        "Interpretacion_resultados": interpretacionResultados,
        "Fuentes_consultadas": fuentesConsultadas,
        "Nombre_corto": nombreCorto,
        "Nombre_proyecto": nombreProyecto,
        "Objetivo": objetivo,
        "Descripcion_general": descripcionGeneral,
        "Prospecto_resultados": prospectoResultados,
        "Id_naturalezaTecnica": idNaturalezaTecnica,
        "Tipo": tipo,
        "Id_area": idArea,
        "Nombre_area": nombreArea,
        "Id_categoria": idCategoria,
        "Nombre_categoria": nombreCategoria,
      };
}
