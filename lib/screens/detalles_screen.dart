import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:innova_ito/theme/cambiar_tema.dart';

class DetallesScreen extends StatefulWidget {
  const DetallesScreen({super.key});

  @override
  State<DetallesScreen> createState() => _DetallesScreenState();
}

class _DetallesScreenState extends State<DetallesScreen> {

  List lista = [];
  
  Future<void> getProyectos() async {
    String url = 'https://evarafael.com/Aplicacion/rest/verProyectosPendientes.php';  
    var response = await http.get(Uri.parse(url));
    setState(() {
      lista = json.decode(response.body);
    });
    //return json.decode(response.body);
  }

  @override
  void initState(){
    getProyectos();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Expanded(

      child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: lista.length,
                              itemBuilder: (context, index){
                                print(lista.length);
                                return Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 10,
        child: Container(
           width: 350,
          //height: 100,
          padding: const EdgeInsets.all(10),
          //margin: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            color: CambiarTema.grey100,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lista[index]["Nombre_corto"],
                    style: TextStyle(
                        color: CambiarTema.bluegrey700,
                        //fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    'Categoria: ${lista[index]["Nombre_categoria"]}',
                    style: TextStyle(
                        color: CambiarTema.bluegrey700,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(
                        icon: const Icon(Icons.visibility_rounded, size: 30),
                        onPressed: () {},
                        color: CambiarTema.bluegrey700),
                    Text(
                      'Visualizar',
                      style: TextStyle(
                        color:  CambiarTema.bluegrey700,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.trip_origin_rounded,
                          color: (true)
                              ? CambiarTema.greenS400
                              : CambiarTema.redA400, size: 30),
                      onPressed: null,
                    ),
                    //SizedBox(zi),
                    Text(
                      'Asesor',
                      style: TextStyle(
                        color:  CambiarTema.bluegrey700,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Switch(
                      value: true,
                      onChanged: (value) => print('hola'),
                      activeColor: CambiarTema.pizazz,
                    ),
                    Text(
                      'Aceptar',
                      style: TextStyle(
                        color: CambiarTema.bluegrey700,
                      ),
                    )
                  ],
                )
              ],
            ),
          ]),
        ),
      );
                              }
                            ),
    );
    
  }
}
