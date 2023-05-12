// To parse this JSON data, do
//
//     final tipoTecnologico = tipoTecnologicoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<TipoTecnologico> tipoTecnologicoFromJson(String str) =>
    List<TipoTecnologico>.from(
        json.decode(str).map((x) => TipoTecnologico.fromJson(x)));

String tipoTecnologicoToJson(List<TipoTecnologico> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TipoTecnologico {
  String idTipoTec;
  String tipoTec;

  TipoTecnologico({
    required this.idTipoTec,
    required this.tipoTec,
  });

  factory TipoTecnologico.fromJson(Map<String, dynamic> json) =>
      TipoTecnologico(
        idTipoTec: json["Id_tipoTec"],
        tipoTec: json["Tipo_tec"],
      );

  Map<String, dynamic> toJson() => {
        "Id_tipoTec": idTipoTec,
        "Tipo_tec": tipoTec,
      };
}
