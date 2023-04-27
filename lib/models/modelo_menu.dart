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
      titulo: "Inicio de sesión",
      icono: Icons.not_started_rounded,
      pantalla: 'acceso'),
  ModeloMenu(
      titulo: "Ficha tecnica",
      icono: Icons.note_add_rounded,
      pantalla: 'ficha_tecnica'),
  ModeloMenu(
      titulo: "Carreras", icono: Icons.note_add_rounded, pantalla: 'carrera'),
  ModeloMenu(
      titulo: "Departamentos",
      icono: Icons.note_add_rounded,
      pantalla: 'departamento'),
  ModeloMenu(
      titulo: "Fechas",
      icono: Icons.note_add_rounded,
      pantalla: 'asignacion_fechas'),
];

List<ModeloMenu> itemsConfig = const [
  ModeloMenu(
      titulo: "Notificaciones",
      icono: Icons.notifications,
      pantalla: 'notificaciones'),
  ModeloMenu(titulo: "Cuenta", icono: Icons.person, pantalla: 'cuenta'),
  ModeloMenu(
      titulo: "Cerrar sesión", icono: Icons.logout_rounded, pantalla: 'salir'),
];
