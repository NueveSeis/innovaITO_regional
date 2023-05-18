import 'dart:convert';

List<Departamento> departamentoFromJson(String str) => List<Departamento>.from(
    json.decode(str).map((x) => Departamento.fromJson(x)));

String departamentoToJson(List<Departamento> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Departamento {
  String idDepartamento;
  String nombreDepartamento;
  String claveTecnologico;

  Departamento({
    required this.idDepartamento,
    required this.nombreDepartamento,
    required this.claveTecnologico,
  });

  factory Departamento.fromJson(Map<String, dynamic> json) => Departamento(
        idDepartamento: json["Id_departamento"],
        nombreDepartamento: json["Nombre_departamento"],
        claveTecnologico: json["Clave_tecnologico"],
      );

  Map<String, dynamic> toJson() => {
        "Id_departamento": idDepartamento,
        "Nombre_departamento": nombreDepartamento,
        "Clave_tecnologico": claveTecnologico,
      };
}
