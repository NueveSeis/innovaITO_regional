import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/screens/detalles_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:innova_ito/widgets/widgets.dart';
import 'package:innova_ito/theme/cambiar_tema.dart';

class ProyectosPendientesScreen extends StatefulWidget {
  static const String name = 'proyectos';
  const ProyectosPendientesScreen({super.key});

  @override
  State<ProyectosPendientesScreen> createState() =>
      _ProyectosPendientesScreenState();
}

class _ProyectosPendientesScreenState extends State<ProyectosPendientesScreen> {
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

  @override
  Widget build(BuildContext context) {
    // ProyectoModelo proyectoModelo = itemsProyecto.first;
    final temaApp = Provider.of<CambiarTema>(context);

    return Scaffold(
      //backgroundColor: CambiarTema.balticSea,
      body: Container(
        //padding: EdgeInsets.only(bottom: 10),
        height: double.infinity,
        width: double.infinity,
        color: CambiarTema.primario,
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
                      icon: Icon(Icons.clear_all_rounded)),
                  Text(
                    'Proyecto',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  IconButton(
                      iconSize: 40,
                      color: Colors.white,
                      onPressed: () {},
                      icon: Icon(Icons.search)),
                ],
              ),
              //SizedBox(height: 10),
              //BarraBotones(),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: (temaApp.temaOscuro)
                        ? CambiarTema.balticSea
                        : CambiarTema.indigo50,
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
                          disabledColor: (temaApp.temaOscuro)
                              ? CambiarTema.emperor
                              : CambiarTema.grey100,
                          elevation: 10,
                          height: 30,
                          color: (temaApp.temaOscuro)
                              ? (aprobados)
                                  ? CambiarTema.pizazz
                                  : CambiarTema.emperor
                              : (aprobados)
                                  ? CambiarTema.pizazz
                                  : CambiarTema.grey100,
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              child: Text(
                                'Aprobados',
                                style: TextStyle(
                                    color: (temaApp.temaOscuro)
                                        ? Colors.white
                                        : (aprobados)
                                            ? Colors.white
                                            : CambiarTema.bluegrey700),
                              )),
                          onPressed: () {
                            setState(() {
                              aprobados = true;
                              pendiente = false;
                            });
                          }),
                      MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          disabledColor: CambiarTema.emperor,
                          elevation: 10,
                          height: 30,
                          color: (temaApp.temaOscuro)
                              ? (pendiente)
                                  ? CambiarTema.pizazz
                                  : CambiarTema.emperor
                              : (pendiente)
                                  ? CambiarTema.pizazz
                                  : CambiarTema.grey100,
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              child: Text(
                                'Pendientes',
                                style: TextStyle(
                                    color: (temaApp.temaOscuro)
                                        ? Colors.white
                                        : (pendiente)
                                            ? Colors.white
                                            : CambiarTema.bluegrey700),
                              )),
                          onPressed: () {
                            setState(() {
                              pendiente = true;
                              aprobados = false;
                            });
                          })
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: (temaApp.temaOscuro)
                        ? CambiarTema.balticSea
                        : CambiarTema.indigo50,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                  ),
                  child: SingleChildScrollView(
                      child: (aprobados) ? DetallesScreen() : Text('No')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
