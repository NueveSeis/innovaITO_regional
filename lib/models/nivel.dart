import 'dart:convert';

List<Nivel> nivelFromJson(String str) =>
    List<Nivel>.from(json.decode(str).map((x) => Nivel.fromJson(x)));

String nivelToJson(List<Nivel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Nivel {
  String idNivel;
  String nombreNivel;
  String descripcionNivel;

  Nivel({
    required this.idNivel,
    required this.nombreNivel,
    required this.descripcionNivel,
  });

  factory Nivel.fromJson(Map<String, dynamic> json) => Nivel(
        idNivel: json["Id_nivel"],
        nombreNivel: json["Nombre_nivel"],
        descripcionNivel: json["Descripcion_nivel"],
      );

  Map<String, dynamic> toJson() => {
        "Id_nivel": idNivel,
        "Nombre_nivel": nombreNivel,
        "Descripcion_nivel": descripcionNivel,
      };
}
