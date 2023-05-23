import 'dart:convert';

List<Categoria> categoriaFromJson(String str) =>
    List<Categoria>.from(json.decode(str).map((x) => Categoria.fromJson(x)));

String categoriaToJson(List<Categoria> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categoria {
  String idCategoria;
  String nombreCategoria;

  Categoria({
    required this.idCategoria,
    required this.nombreCategoria,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        idCategoria: json["Id_categoria"],
        nombreCategoria: json["Nombre_categoria"],
      );

  Map<String, dynamic> toJson() => {
        "Id_categoria": idCategoria,
        "Nombre_categoria": nombreCategoria,
      };
}
