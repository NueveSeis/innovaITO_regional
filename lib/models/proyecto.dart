import 'dart:convert';

List<Proyecto> proyectoFromJson(String str) =>
    List<Proyecto>.from(json.decode(str).map((x) => Proyecto.fromJson(x)));

String proyectoToJson(List<Proyecto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Proyecto {
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

  Proyecto({
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
  });

  factory Proyecto.fromJson(Map<String, dynamic> json) => Proyecto(
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
      );

  Map<String, dynamic> toJson() => {
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
      };
}
