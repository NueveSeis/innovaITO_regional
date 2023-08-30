import 'package:flutter/material.dart';
import 'package:innova_ito/widgets/widgets.dart';

import 'package:flutter_summernote/flutter_summernote.dart';

//import 'package:html_editor/html_editor.dart';

class InicioScreen extends StatefulWidget {
  static const String name = 'inicio';
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  GlobalKey<FlutterSummernoteState> _keyEditor = GlobalKey();

  String result = '';
  @override
  Widget build(BuildContext context) {
    //HtmlEditorController controller = HtmlEditorController();

    return Scaffold(
      body: Fondo(
          fontSize: 20,
          tituloPantalla: 'prueba',
          widget: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  width: 300, // Ancho de la tabla
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Table(
                    columnWidths: const {
                      0: FixedColumnWidth(100), // Ancho de la primera columna
                      1: FlexColumnWidth(
                          200), // Segunda columna ocupa espacio restante
                    }, // Ancho de la primera columna
                    border: TableBorder.all(),
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment
                                  .centerLeft, // Alineación a la izquierda
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: const Text('Folio:'),
                            ),
                          ),
                          const TableCell(
                            child: Center(child: Text('Columna 2')),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment
                                  .centerLeft, // Alineación a la izquierda
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: const Text('Nombre corto:'),
                            ),
                          ),
                          const TableCell(
                            child: Center(child: Text('Columna 2')),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment
                                  .centerLeft, // Alineación a la izquierda
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: const Text('Nombre descriptivo:'),
                            ),
                          ),
                          const TableCell(
                            child: Center(child: Text('Columna 2')),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment
                                  .centerLeft, // Alineación a la izquierda
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: const Text('Categoría:'),
                            ),
                          ),
                          const TableCell(
                            child: Center(child: Text('Columna 2')),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment
                                  .centerLeft, // Alineación a la izquierda
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: const Text('Sector estratégico:'),
                            ),
                          ),
                          const TableCell(
                            child: Center(child: Text('Columna 2')),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment
                                  .centerLeft, // Alineación a la izquierda
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: const Text('Naturaleza técnica:'),
                            ),
                          ),
                          const TableCell(
                            child: Center(child: Text('Columna 2')),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
