import 'dart:convert';

List<Carrera> carreraFromJson(String str) =>
    List<Carrera>.from(json.decode(str).map((x) => Carrera.fromJson(x)));

String carreraToJson(List<Carrera> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Carrera {
  String idCarrera;
  String nombreCarrera;
  String idNivel;
  String idDepartamento;

  Carrera({
    required this.idCarrera,
    required this.nombreCarrera,
    required this.idNivel,
    required this.idDepartamento,
  });

  factory Carrera.fromJson(Map<String, dynamic> json) => Carrera(
        idCarrera: json["Id_carrera"],
        nombreCarrera: json["Nombre_carrera"],
        idNivel: json["Id_nivel"],
        idDepartamento: json["Id_departamento"],
      );

  Map<String, dynamic> toJson() => {
        "Id_carrera": idCarrera,
        "Nombre_carrera": nombreCarrera,
        "Id_nivel": idNivel,
        "Id_departamento": idDepartamento,
      };
}
