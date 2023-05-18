import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/helpers/helpers.dart';
import 'package:innova_ito/providers/acceso_formulario_prov.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/theme/app_tema.dart';

class AccesoScreen extends StatelessWidget {
  const AccesoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FondoAcceso(
      child: SingleChildScrollView(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(
              height: 250,
            ),
            ContenedorCarta(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Acceso',
                    style: TextStyle(
                        color: AppTema.balticSea,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ChangeNotifierProvider(
                    create: (_) => AccesoFormularioProv(),
                    child: _formularioAcceso(),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButton(
                      child: const Text(
                        'Registrar',
                        style: TextStyle(
                            color: AppTema.primario,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        String barcodeScanRes =
                            await FlutterBarcodeScanner.scanBarcode(
                                '#fa7a1e', 'Cancelar', false, ScanMode.QR);
                        if (barcodeScanRes == '20230422') {
                          //print(barcodeScanRes);
                          Navigator.pushReplacementNamed(
                              context, 'registro_usuario_asesor');
                        }
                      }),
                  TextButton(
                      child: const Text(
                        '¿Olvidó su contraseña?',
                        style: TextStyle(
                            color: Color.fromRGBO(46, 45, 47, 0.8),
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class _formularioAcceso extends StatefulWidget {
  @override
  State<_formularioAcceso> createState() => _formularioAccesoState();
}

class _formularioAccesoState extends State<_formularioAcceso> {
  TextEditingController correo = TextEditingController();
  TextEditingController contrasena = TextEditingController();
  List lista = [];
  String contrasenaHash = '';

  Future<String> getUsuario(String usuario) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/obtenerUsuario.php?Nombre_usuario=$usuario';
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      var datos = jsonDecode(response.body);
      String miString = datos[0]['Contrasena'].toString();
      return miString;
    } else {
      return '';
      print('Error al obtener datos de la API');
    }
  }

  Future acceso() async {
    String url = 'https://evarafael.com/Aplicacion/rest/login.php';
    var response = await http.post(Uri.parse(url), body: {
      "Nombre_usuario": correo.text,
    });

    var data = json.decode(response.body);
    if (data == "Realizado") {
      Navigator.pushReplacementNamed(context, 'menu_lateral');
    }
  }

  @override
  Widget build(BuildContext context) {
    final accesoFormulario = Provider.of<AccesoFormularioProv>(context);
    return Container(
      child: Form(
          key: accesoFormulario.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(children: [
            TextFormField(
              controller: correo,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.accesoInputDecoration(
                  hintText: 'Correo electronico',
                  labelText: 'Correo electronico',
                  prefixIcon: Icons.person),
              onChanged: (value) => accesoFormulario.correo = value,
              validator: (value) {
                return RegexUtil.correo.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no es un correo.';
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: contrasena,
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.accesoInputDecoration(
                  hintText: '******',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.key),
              onChanged: (value) => accesoFormulario.contrasena = value,
              validator: (value) {
                return RegexUtil.contrasena.hasMatch(value ?? '')
                    ? null
                    : 'No es una contraseña valida.';
              },
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                disabledColor: Colors.grey,
                elevation: 10,
                color: const Color.fromRGBO(250, 122, 30, 1),
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 15),
                    child: const Text(
                      'Ingresar',
                      style: TextStyle(color: Colors.white),
                    )),
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (!accesoFormulario.esValidoFormulario()) return;
                  String pass = await getUsuario(correo.text);

                  bool comparado = Generar.compararContrasena(
                      contrasena.text.toString(), pass);
                  print(comparado);
                  if (comparado == true) {
                    acceso();
                  } else {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Datos incorrectos',
                      text: 'Verifique su correo electronico y contraseña',
                      confirmBtnText: 'Hecho',
                      confirmBtnColor: AppTema.pizazz,
                    );
                  }
                }),
          ])),
    );
  }
}
