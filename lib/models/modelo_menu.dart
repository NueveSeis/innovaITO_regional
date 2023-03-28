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
      pantalla: 'detalles'),
  ModeloMenu(
      titulo: "Registro de horario",
      icono: Icons.calendar_month_rounded,
      pantalla: 'acceso'),
  ModeloMenu(
      titulo: "Resultado de evaluación",
      icono: Icons.playlist_add_check_circle_rounded,
      pantalla: 'detalles'),
  ModeloMenu(
      titulo: "Proyectos",
      icono: Icons.document_scanner_rounded,
      pantalla: 'proyectos'),
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
