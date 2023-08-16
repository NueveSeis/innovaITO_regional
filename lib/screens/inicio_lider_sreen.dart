import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/screens/detalles_screen.dart';
import 'package:innova_ito/screens/ficha_tecnica_screen.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:innova_ito/widgets/widgets.dart';

class InicioLiderScreen extends StatefulWidget {
  static const String name = 'inicioLider';
  const InicioLiderScreen({super.key});

  @override
  State<InicioLiderScreen> createState() => _InicioLiderScreenState();
}

class _InicioLiderScreenState extends State<InicioLiderScreen> {
  List lista = [];

  Future<void> getProyectos() async {
    String url = 'https://evarafael.com/Aplicacion/rest/verProyectos.php';
    var response = await http.get(Uri.parse(url));
    setState(() {
      lista = json.decode(response.body);
    });
    //return json.decode(response.body);
  }

  @override
  void initState() {
    getProyectos();
    super.initState();
  }

  bool pendiente = true;
  bool aprobados = false;

  List<Map<String, dynamic>> listaItems = [
    {
      "titulo": "Mis datos",
      "icono": Icons.desktop_mac_rounded,
      "pantalla": 'actualizar_lider',
    },
    {
      "titulo": "Ficha tecnica",
      "icono": Icons.note_add_rounded,
      "pantalla": 'ficha_tecnica',
    },
    {
      "titulo": "Memoria tecnica",
      "icono": Icons.edit_note_rounded,
      "pantalla": 'memoria_tecnica',
    },
    {
      "titulo": "Participantes",
      "icono": Icons.person_add_alt_1_rounded,
      "pantalla": 'participantes',
    },
    {
      "titulo": "Requerimientos Especiales",
      "icono": Icons.home_repair_service_rounded,
      "pantalla": 'requerimientos_lider',
    },
    {
      "titulo": "Modelo de negocio",
      "icono": Icons.upload_file_rounded,
      "pantalla": 'modelo_negocio',
    },
    {
      "titulo": "Asesor",
      "icono": Icons.person_add_alt_rounded,
      "pantalla": 'asesor_lider',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // ProyectoModelo proyectoModelo = itemsProyecto.first;

    return Scaffold(
      //backgroundColor: AppTema.balticSea,
      body: Container(
        //padding: EdgeInsets.only(bottom: 10),
        height: double.infinity,
        width: double.infinity,
        color: AppTema.primario,
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      iconSize: 45,
                      color: Colors.white,
                      onPressed: () {
                        context.pushNamed('menu_lateral');
                        // Navigator.pushNamed(context, 'menu_lateral');
                      },
                      icon: const Icon(Icons.clear_all_rounded)),
                  const Text(
                    'Inicio',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  SizedBox(
                    width: 45,
                  )
                ],
              ),
              //SizedBox(height: 10),
              //BarraBotones(),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppTema.indigo50,
                  ),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          disabledColor: AppTema.grey100,
                          elevation: 10,
                          height: 30,
                          color: (aprobados) ? AppTema.pizazz : AppTema.grey100,
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              child: Text(
                                'SIN FOLIO',
                                style: TextStyle(
                                    color: (aprobados)
                                        ? Colors.white
                                        : AppTema.bluegrey700),
                              )),
                          onPressed: () {}),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppTema.indigo50,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                  ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: listaItems.length,
                    itemBuilder: (context, index) {
                      return TareasLider(
                        icono: listaItems[index]['icono'],
                        texto: listaItems[index]['titulo'],
                        ruta1: listaItems[index]['pantalla'],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
