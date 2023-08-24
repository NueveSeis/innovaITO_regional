import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/screens/screens.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/widgets/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

class TablaPosicionesScreen extends StatelessWidget {
  static const String name = 'tabla_posiciones';
  TablaPosicionesScreen({super.key});

  List<Tablero> tablero = [];

  Future<Uint8List> generatePdf() async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(
              "This is a sample pdf generated in Flutter",
              style: const pw.TextStyle(
                fontSize: 25,
              ),
            ),
          ); // Center
        }));

    var image = await networkImage('https://picsum.photos/250?image=9');
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(image),
          ); // Center
        }));

    final output = await getTemporaryDirectory();
    debugPrint("${output.path}/example.pdf");
    final file = File("${output.path}/example.pdf");
    await file.writeAsBytes(await pdf.save());
    return pdf.save();
  }

  Future obtenerPosiciones() async {
    var url = 'https://evarafael.com/Aplicacion/rest/get_proyectos.php';
    var response = await http.get(Uri.parse(url));
    tablero = tableroFromJson(response.body);
    tablero.sort((a, b) => double.parse(b.calificacionGlobal)
        .compareTo(double.parse(a.calificacionGlobal)));
    print('hola');
    print(tablero[0].nombreArea);
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
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      // return Center(
                      //     child: Text('Error: ${snapshot.error.toString()}'));
                      return Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
                            'Calificaciones no asignadas',
                            style: TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Container(
                            height: 60,
                            width: size.width / 2,
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: ElevatedButton(
                              child: const Center(
                                  child: Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Icon(Icons.gavel_rounded),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Finalizar Evento',
                                    style: TextStyle(
                                        color: AppTema.grey100, fontSize: 15),
                                  ),
                                ],
                              )),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          Container(
                            height: 50,
                            width: size.width / 2,
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: ElevatedButton(
                              child: const Center(
                                  child: Column(
                                children: [
                                  Icon(Icons.cloud_download_rounded),
                                  Text(
                                    'Descargar tablero',
                                    style: TextStyle(
                                        color: AppTema.grey100, fontSize: 15),
                                  ),
                                ],
                              )),
                              onPressed: () {},
                            ),
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
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
                        ],
                      );
                    }
                  } else {
                    return const Center(child: Text('Something went wrong!'));
                  }
                },
              ),
            ],
          ),
        ));
  }
}
