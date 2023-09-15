import 'package:flutter/material.dart';

class ModeloMenu {
  final String titulo;
  final IconData icono;
  final String? pantalla;
  const ModeloMenu({this.pantalla, required this.titulo, required this.icono});
}

List<ModeloMenu> itemsMenu = const [
  //!Quitar pantalla borrar
  //ModeloMenu(titulo: "Inicio", icono: Icons.home_rounded, pantalla: 'inicio'),
  ModeloMenu(
      titulo: "Registro de usuario",
      icono: Icons.group_add_rounded,
      pantalla: 'registro_usuario'),
  /////   titulo: "Registro de horario",
  //icono: Icons.calendar_month_rounded,
  //pantalla: 'acceso'),
  //!Quitar panatalla borrar
  // ModeloMenu(
  //     titulo: "Resultado de evaluación",
  //     icono: Icons.playlist_add_check_circle_rounded,
  //     pantalla: 'detalles'),
  //!Quitar pantalla no se utiliza
  // ModeloMenu(
  //     titulo: "Proyectos",
  //     icono: Icons.document_scanner_rounded,
  //     pantalla: 'proyectos'),
  ModeloMenu(
      titulo: "Carreras", icono: Icons.school_rounded, pantalla: 'carrera'),
  ModeloMenu(
      titulo: "Departamentos",
      icono: Icons.note_add_rounded,
      pantalla: 'departamento'),
  //! Modificar
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
  //Inicio para lider de proyecto
  ModeloMenu(
      titulo: "Inicio", icono: Icons.home_rounded, pantalla: 'inicioLider'),
  ModeloMenu(
      titulo: "Participantes",
      icono: Icons.person_add_alt_1_rounded,
      pantalla: 'participantes'),
  //! Quitar pantalla no necesaria
  // ModeloMenu(
  //     titulo: "Criterios", icono: Icons.assignment, pantalla: 'criterios'),
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
      icono: Icons.biotech_rounded,
      pantalla: 'naturaleza_admin'),
  ModeloMenu(
      titulo: "Regiones",
      icono: Icons.school_rounded,
      pantalla: 'region_admin'),
  ModeloMenu(
      titulo: "Genero", icono: Icons.school_rounded, pantalla: 'genero_admin'),
  ModeloMenu(
      titulo: "Modelo de negocio",
      icono: Icons.upload_file_rounded,
      pantalla: 'modelo_negocio'),
  //!Quitar pantalla
  // ModeloMenu(
  //     titulo: "Rubricas", icono: Icons.school_rounded, pantalla: 'rubrica'),
  ModeloMenu(
      titulo: "Requerimientos Especiales",
      icono: Icons.home_repair_service_rounded,
      pantalla: 'requerimientos_lider'),
  ModeloMenu(
      titulo: "Asesor",
      icono: Icons.person_add_alt_rounded,
      pantalla: 'asesor_lider'),
  ModeloMenu(
      titulo: "Mis proyectos",
      icono: Icons.document_scanner_rounded,
      pantalla: 'proyecto_asesor'),
  ModeloMenu(
      titulo: "Mis proyectos",
      icono: Icons.document_scanner_rounded,
      pantalla: 'proyecto_coordinador'),
  ModeloMenu(
      titulo: "Agregar Rubrica",
      icono: Icons.post_add_rounded,
      pantalla: 'agregar_rubrica'),
  ModeloMenu(
      titulo: "Asignar Sala",
      icono: Icons.meeting_room_rounded,
      pantalla: 'Sala'),
  ModeloMenu(
      titulo: "Asignar stand",
      icono: Icons.table_restaurant_rounded,
      pantalla: 'stand'),
  //! Lugar de evaluacion del proyecto - Lider
  ModeloMenu(
      titulo: "Sala Lider",
      icono: Icons.location_pin,
      pantalla: 'salaLiderScreen'),
  //! Jurado
  ModeloMenu(
      titulo: "Evaluaciones pendientes sala",
      icono: Icons.assignment_turned_in_outlined,
      pantalla: 'proyectoEvaluarScreen'),
  //!Asignar proyecto a jurado - Coordinador
  ModeloMenu(
      titulo: "Asignar Proyecto a jurado",
      icono: Icons.assignment_ind_rounded,
      pantalla: 'AsignarProyectoJuradoScreen'),
  //! Jurado
  ModeloMenu(
      titulo: "Evaluaciones pendientes stand",
      icono: Icons.assignment_turned_in_outlined,
      pantalla: 'ProyectoEvaluarStandSreen'),
];

List<ModeloMenu> itemsLider = const [
  ModeloMenu(
      titulo: "Inicio", icono: Icons.home_rounded, pantalla: 'inicioLider'),
  ModeloMenu(
      titulo: "Mis datos",
      icono: Icons.desktop_mac_rounded,
      pantalla: 'actualizar_lider'),
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
  ModeloMenu(
      titulo: "Requerimientos Especiales",
      icono: Icons.home_repair_service_rounded,
      pantalla: 'requerimientos_lider'),
  ModeloMenu(
      titulo: "Modelo de negocio",
      icono: Icons.upload_file_rounded,
      pantalla: 'modelo_negocio'),
  ModeloMenu(
      titulo: "Asesor",
      icono: Icons.person_add_alt_rounded,
      pantalla: 'asesor_lider'),
  //! Lugar de evaluacion del proyecto - Lider
  ModeloMenu(
      titulo: "Sala Lider",
      icono: Icons.location_pin,
      pantalla: 'salaLiderScreen'),
];

List<ModeloMenu> itemsAsesor = const [
  ModeloMenu(
      titulo: "Inicio", icono: Icons.home_rounded, pantalla: 'inicioLider'),
  ModeloMenu(
      titulo: "Mis proyectos",
      icono: Icons.document_scanner_rounded,
      pantalla: 'proyecto_asesor'),
];

List<ModeloMenu> itemsJuradoInterno = const [
  ModeloMenu(
      titulo: "Inicio", icono: Icons.home_rounded, pantalla: 'inicioLider'),
  ModeloMenu(
      titulo: "Seleccionar categoria",
      icono: Icons.category_rounded,
      pantalla: 'seleccionar_categoria'),
  //! Jurado
  ModeloMenu(
      titulo: "Evaluaciones Sala",
      icono: Icons.assignment_turned_in_outlined,
      pantalla: 'proyectoEvaluarScreen'),
  ModeloMenu(
      titulo: "Evaluaciones Stand",
      icono: Icons.assignment_turned_in_outlined,
      pantalla: 'ProyectoEvaluarStandSreen'),
];

List<ModeloMenu> itemsJuradoExterno = const [
  ModeloMenu(
      titulo: "Seleccionar categoria",
      icono: Icons.category_rounded,
      pantalla: 'seleccionar_categoria'),
];

List<ModeloMenu> itemsCoordinadorLocal = const [
  ModeloMenu(
      titulo: "Inicio", icono: Icons.home_rounded, pantalla: 'inicioLider'),
  ModeloMenu(
      titulo: "Registro de usuario",
      icono: Icons.group_add_rounded,
      pantalla: 'registro_usuario'),
  ModeloMenu(
      titulo: "Carreras", icono: Icons.school_rounded, pantalla: 'carrera'),
  ModeloMenu(
      titulo: "Departamentos",
      icono: Icons.note_add_rounded,
      pantalla: 'departamento'),
  // //! Modificar
  // ModeloMenu(
  //     titulo: "Fechas",
  //     icono: Icons.calendar_month_rounded,
  //     pantalla: 'asignacion_fechas'),
  ModeloMenu(
      titulo: "Mis proyectos",
      icono: Icons.document_scanner_rounded,
      pantalla: 'proyecto_coordinador'),
  ModeloMenu(
      titulo: "Rubricas",
      icono: Icons.post_add_rounded,
      pantalla: 'RubricaScreen'),
  ModeloMenu(
      titulo: "Asignar Sala",
      icono: Icons.meeting_room_rounded,
      pantalla: 'Sala'),
  ModeloMenu(
      titulo: "Asignar stand",
      icono: Icons.table_restaurant_rounded,
      pantalla: 'stand'),
  //!Asignar proyecto a jurado - Coordinador
  ModeloMenu(
      titulo: "Asignar Proyecto a jurado",
      icono: Icons.assignment_ind_rounded,
      pantalla: 'AsignarProyectoJuradoScreen'),
  ModeloMenu(
      titulo: "Tablero de posiciones",
      icono: Icons.leaderboard_rounded,
      pantalla: 'tabla_posiciones'),
  // ModeloMenu(
  //     titulo: "Generar constancia",
  //     icono: Icons.picture_as_pdf_rounded,
  //     pantalla: 'GeneracionConstanciaScreen'),
  ModeloMenu(
      titulo: "Generar PDFS",
      icono: Icons.picture_as_pdf_rounded,
      pantalla: 'GeneraPdfScreen'),
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

List<ModeloMenu> itemsAdministrador = const [
  ModeloMenu(
      titulo: "Inicio", icono: Icons.home_rounded, pantalla: 'inicioLider'),
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
      icono: Icons.biotech_rounded,
      pantalla: 'naturaleza_admin'),
  ModeloMenu(
      titulo: "Regiones",
      icono: Icons.school_rounded,
      pantalla: 'region_admin'),
  ModeloMenu(
      titulo: "Genero", icono: Icons.school_rounded, pantalla: 'genero_admin'),
];

List<ModeloMenu> itemsConfig = const [
  // ModeloMenu(
  //     titulo: "Notificaciones",
  //     icono: Icons.notifications,
  //     pantalla: 'notificaciones'),
  // ModeloMenu(titulo: "Cuenta", icono: Icons.person, pantalla: 'cuenta'),
  ModeloMenu(
      titulo: "Cerrar sesión", icono: Icons.logout_rounded, pantalla: 'acceso'),
];

//!    MODELOS PARA LA ETAPA REGIONAL

List<ModeloMenu> itemsLiderRegional = const [
  ModeloMenu(
      titulo: "Inicio", icono: Icons.home_rounded, pantalla: 'inicioLider'),
  ModeloMenu(
      titulo: "Presentación",
      icono: Icons.location_pin,
      pantalla: 'SubirPresentacionScreen'),
];

List<ModeloMenu> itemsCoordinadorLocalRegional = const [
  ModeloMenu(
      titulo: "Inicio", icono: Icons.home_rounded, pantalla: 'inicioLider'),
  ModeloMenu(
      titulo: "Generar PDFS",
      icono: Icons.picture_as_pdf_rounded,
      pantalla: 'GeneraPdfRegionalScreen'),
];
