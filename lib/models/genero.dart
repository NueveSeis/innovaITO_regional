import 'dart:convert';

List<Genero> generoFromJson(String str) =>
    List<Genero>.from(json.decode(str).map((x) => Genero.fromJson(x)));

String generoToJson(List<Genero> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Genero {
  String idGenero;
  String tipoGenero;

  Genero({
    required this.idGenero,
    required this.tipoGenero,
  });

  factory Genero.fromJson(Map<String, dynamic> json) => Genero(
        idGenero: json["Id_genero"],
        tipoGenero: json["Tipo_genero"],
      );

  Map<String, dynamic> toJson() => {
        "Id_genero": idGenero,
        "Tipo_genero": tipoGenero,
      };
}
