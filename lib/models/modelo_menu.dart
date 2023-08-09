import 'package:flutter/material.dart';

class ModeloMenu {
  final String titulo;
  final IconData icono;
  final String? pantalla;
  const ModeloMenu({this.pantalla, required this.titulo, required this.icono});
}

List<ModeloMenu> itemsMenu = const [
  ModeloMenu(titulo: "Inicio", icono: Icons.home_rounded, pantalla: 'inicio'),
  ModeloMenu(
      titulo: "Registro de usuario",
      icono: Icons.group_add_rounded,
      pantalla: 'registro_usuario'),
  /////   titulo: "Registro de horario",
  //icono: Icons.calendar_month_rounded,
  //pantalla: 'acceso'),
  ModeloMenu(
      titulo: "Resultado de evaluación",
      icono: Icons.playlist_add_check_circle_rounded,
      pantalla: 'detalles'),
  ModeloMenu(
      titulo: "Proyectos",
      icono: Icons.document_scanner_rounded,
      pantalla: 'proyectos'),
  ModeloMenu(
      titulo: "Carreras", icono: Icons.school_rounded, pantalla: 'carrera'),
  ModeloMenu(
      titulo: "Departamentos",
      icono: Icons.note_add_rounded,
      pantalla: 'departamento'),
  ModeloMenu(
      titulo: "Fechas",
      icono: Icons.calendar_month_rounded,
      pantalla: 'asignacion_fechas'),
  ModeloMenu(
      titulo: "Seleccionar categoria",
      icono: Icons.category_rounded,
      pantalla: 'seleccionar_categoria'),
  ModeloMenu(
      titulo: "Ficha tecnica",
      icono: Icons.note_add_rounded,
      pantalla: 'ficha_tecnica'),
  ModeloMenu(
      titulo: "Memoria tecnica",
      icono: Icons.edit_note_rounded,
      pantalla: 'memoria_tecnica'),
  ModeloMenu(
      titulo: "Tablero de posiciones",
      icono: Icons.leaderboard_rounded,
      pantalla: 'tabla_posiciones'),
  ModeloMenu(
      titulo: "Inicio", icono: Icons.home_rounded, pantalla: 'inicioLider'),
  ModeloMenu(
      titulo: "Participantes",
      icono: Icons.person_add_alt_1_rounded,
      pantalla: 'participantes'),
  ModeloMenu(
      titulo: "Criterios", icono: Icons.assignment, pantalla: 'criterios'),
  ModeloMenu(
      titulo: "Mis datos",
      icono: Icons.desktop_mac_rounded,
      pantalla: 'actualizar_lider'),
  ModeloMenu(
      titulo: "Requerimientos",
      icono: Icons.home_repair_service_rounded,
      pantalla: 'requerimientos'),
  ModeloMenu(
      titulo: "Categorias",
      icono: Icons.category_rounded,
      pantalla: 'categoria_admin'),
  ModeloMenu(
      titulo: "Estados", icono: Icons.map_rounded, pantalla: 'estado_admin'),
  ModeloMenu(
      titulo: "Nivel Academico",
      icono: Icons.school_rounded,
      pantalla: 'nivel_admin'),
  ModeloMenu(
      titulo: "Naturaleza Tecnica",
      icono: Icons.school_rounded,
      pantalla: 'naturaleza_admin'),
  ModeloMenu(
      titulo: "Regiones",
      icono: Icons.school_rounded,
      pantalla: 'region_admin'),
  ModeloMenu(
      titulo: "Genero", icono: Icons.school_rounded, pantalla: 'genero_admin'),
  ModeloMenu(
      titulo: "Modelo de negocio",
      icono: Icons.school_rounded,
      pantalla: 'modelo_negocio'),
  ModeloMenu(
      titulo: "Rubricas", icono: Icons.school_rounded, pantalla: 'rubrica'),
];

List<ModeloMenu> itemsLider = const [
  ModeloMenu(
      titulo: "Ficha tecnica",
      icono: Icons.note_add_rounded,
      pantalla: 'ficha_tecnica'),
  ModeloMenu(
      titulo: "Memoria tecnica",
      icono: Icons.edit_note_rounded,
      pantalla: 'memoria_tecnica'),
  ModeloMenu(
      titulo: "Participantes",
      icono: Icons.person_add_alt_1_rounded,
      pantalla: 'participantes'),
];

List<ModeloMenu> itemsAsesor = const [
  ModeloMenu(
      titulo: "Ficha tecnica",
      icono: Icons.note_add_rounded,
      pantalla: 'ficha_tecnica'),
];

List<ModeloMenu> itemsJuradoInterno = const [
  ModeloMenu(
      titulo: "Ficha tecnica",
      icono: Icons.note_add_rounded,
      pantalla: 'ficha_tecnica'),
];

List<ModeloMenu> itemsJuradoExterno = const [
  ModeloMenu(
      titulo: "Ficha tecnica",
      icono: Icons.note_add_rounded,
      pantalla: 'ficha_tecnica'),
];

List<ModeloMenu> itemsCoordinadorLocal = const [
  ModeloMenu(
      titulo: "Ficha tecnica",
      icono: Icons.note_add_rounded,
      pantalla: 'ficha_tecnica'),
];

List<ModeloMenu> itemsCoordinadorRegional = const [
  ModeloMenu(
      titulo: "Ficha tecnica",
      icono: Icons.note_add_rounded,
      pantalla: 'ficha_tecnica'),
];

List<ModeloMenu> itemsCoordinadorNacional = const [
  ModeloMenu(
      titulo: "Ficha tecnica",
      icono: Icons.note_add_rounded,
      pantalla: 'ficha_tecnica'),
];

List<ModeloMenu> itemsConfig = const [
  ModeloMenu(
      titulo: "Notificaciones",
      icono: Icons.notifications,
      pantalla: 'notificaciones'),
  ModeloMenu(titulo: "Cuenta", icono: Icons.person, pantalla: 'cuenta'),
  ModeloMenu(
      titulo: "Cerrar sesión", icono: Icons.logout_rounded, pantalla: 'acceso'),
];
