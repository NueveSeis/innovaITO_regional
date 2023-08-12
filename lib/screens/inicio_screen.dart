import 'package:flutter/material.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:html_editor_enhanced/utils/callbacks.dart';
import 'package:html_editor_enhanced/utils/file_upload_model.dart';
import 'package:html_editor_enhanced/utils/options.dart';
import 'package:html_editor_enhanced/utils/plugins.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui_fake.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';
import 'package:html_editor_enhanced/utils/shims/flutter_inappwebview_fake.dart';
import 'package:html_editor_enhanced/utils/toolbar.dart';
import 'package:html_editor_enhanced/utils/utils.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
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

    HtmlEditorController controller = HtmlEditorController();

    return Scaffold(
      body: Fondo(
          fontSize: 20,
          tituloPantalla: 'prubea',
          widget: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  width: 300, // Ancho de la tabla
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Table(
                    columnWidths: {
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
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Folio:'),
                            ),
                          ),
                          TableCell(
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
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Nombre corto:'),
                            ),
                          ),
                          TableCell(
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
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Nombre descriptivo:'),
                            ),
                          ),
                          TableCell(
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
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Categoría:'),
                            ),
                          ),
                          TableCell(
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
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Sector estratégico:'),
                            ),
                          ),
                          TableCell(
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
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Naturaleza técnica:'),
                            ),
                          ),
                          TableCell(
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
