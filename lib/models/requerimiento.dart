import 'dart:convert';

List<Requerimientos> requerimientosFromJson(String str) =>
    List<Requerimientos>.from(
        json.decode(str).map((x) => Requerimientos.fromJson(x)));

String requerimientosToJson(List<Requerimientos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Requerimientos {
  String idRequerimientoEspecial;
  String tipo;
  String descripcion;

  Requerimientos({
    required this.idRequerimientoEspecial,
    required this.tipo,
    required this.descripcion,
  });

  factory Requerimientos.fromJson(Map<String, dynamic> json) => Requerimientos(
        idRequerimientoEspecial: json["Id_requerimientoEspecial"],
        tipo: json["Tipo"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "Id_requerimientoEspecial": idRequerimientoEspecial,
        "Tipo": tipo,
        "Descripcion": descripcion,
      };
}
