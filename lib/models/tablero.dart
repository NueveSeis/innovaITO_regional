import 'dart:convert';

List<Tablero> tableroFromJson(String str) =>
    List<Tablero>.from(json.decode(str).map((x) => Tablero.fromJson(x)));

String tableroToJson(List<Tablero> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tablero {
  String calificacionGlobal;
  String nombreCorto;
  String nombreArea;
  String nombreCategoria;
  String nombreProyecto;
  String folio;
  String posicionActual;

  Tablero({
    required this.calificacionGlobal,
    required this.nombreCorto,
    required this.nombreArea,
    required this.nombreCategoria,
    required this.nombreProyecto,
    required this.folio,
    required this.posicionActual,
  });

  factory Tablero.fromJson(Map<String, dynamic> json) => Tablero(
        calificacionGlobal: json["Calificacion_global"],
        nombreCorto: json["Nombre_corto"],
        nombreArea: json["Nombre_area"],
        nombreCategoria: json["Nombre_categoria"],
        nombreProyecto: json["Nombre_proyecto"],
        folio: json["Folio"],
        posicionActual: json["Posicion_actual"],
      );

  Map<String, dynamic> toJson() => {
        "Calificacion_global": calificacionGlobal,
        "Nombre_corto": nombreCorto,
        "Nombre_area": nombreArea,
        "Nombre_categoria": nombreCategoria,
        "Nombre_proyecto": nombreProyecto,
        "Folio": folio,
        "Posicion_actual": posicionActual,
      };
}
