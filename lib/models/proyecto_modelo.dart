import 'package:flutter/material.dart';

class ProyectoModelo {
  final String titulo;
  final String categoria;
  final bool asesorCheck;
  final bool vinculacionCheck;

  ProyectoModelo(
      {required this.titulo,
      required this.categoria,
      required this.asesorCheck,
      required this.vinculacionCheck});
}

List<ProyectoModelo> itemsProyecto = [
  ProyectoModelo(
      titulo: "Arroz Inflado",
      categoria: "Industria creativa",
      asesorCheck: false,
      vinculacionCheck: true),
  ProyectoModelo(
      titulo: "Agua Jamaicana",
      categoria: "Industria creativa",
      asesorCheck: true,
      vinculacionCheck: true),
  ProyectoModelo(
      titulo: "Maruchan ramen",
      categoria: "innovacion",
      asesorCheck: true,
      vinculacionCheck: false),
  ProyectoModelo(
      titulo: "Maruchan ramen",
      categoria: "innovacion",
      asesorCheck: false,
      vinculacionCheck: false),
  ProyectoModelo(
      titulo: "InnovaIto",
      categoria: "innovacion",
      asesorCheck: true,
      vinculacionCheck: true),
  ProyectoModelo(
      titulo: "Agua de piña",
      categoria: "innovacion",
      asesorCheck: true,
      vinculacionCheck: true),
];
