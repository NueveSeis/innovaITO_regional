import 'package:flutter/material.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class TablaPosicionesScreen extends StatelessWidget {
  static const String name = 'tabla_posiciones';
  TablaPosicionesScreen({super.key});

  List<Tablero> tablero = [];

  Future obtenerPosiciones() async {
    var url = 'https://evarafael.com/Aplicacion/rest/get_proyectos.php';
    var response = await http.get(Uri.parse(url));
    tablero = tableroFromJson(response.body);
    tablero
        .sort((a, b) => b.calificacionGlobal.compareTo(a.calificacionGlobal));
    //print(tecnologicoM[0].nombreTecnologico);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Fondo(
        tituloPantalla: 'Tablero de posiciones',
        fontSize: 20,
        widget: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              Container(
                height: 50,
                width: size.width / 2,
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: ElevatedButton(
                  child: const Center(
                      child: Column(
                    children: [
                      Icon(Icons.cloud_download_rounded),
                      Text(
                        'Descargar tablero',
                        style: TextStyle(color: AppTema.grey100, fontSize: 15),
                      ),
                    ],
                  )),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder(
                  future: obtenerPosiciones(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: tablero.length,
                          itemBuilder: (context, index) {
                            return CardPosiciones(
                              posicion: index + 1,
                              nombreCategoria: tablero[index].nombreArea,
                              nombreProyecto: tablero[index].nombreCorto,
                              nombreTecnologico: tablero[index].nombreArea,
                              calificacion: tablero[index].calificacionGlobal,
                            );
                          },
                        ),
                      );
                    }
                  }),
            ],
          ),
        ));
  }
}
