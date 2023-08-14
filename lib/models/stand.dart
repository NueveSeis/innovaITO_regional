// To parse this JSON data, do
//
//     final stand = standFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Stand> standFromJson(String str) =>
    List<Stand>.from(json.decode(str).map((x) => Stand.fromJson(x)));

String standToJson(List<Stand> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Stand {
  String idStand;
  String lugar;

  Stand({
    required this.idStand,
    required this.lugar,
  });

  factory Stand.fromJson(Map<String, dynamic> json) => Stand(
        idStand: json["Id_stand"],
        lugar: json["Lugar"],
      );

  Map<String, dynamic> toJson() => {
        "Id_stand": idStand,
        "Lugar": lugar,
      };
}
