import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/helpers/helpers.dart';
import 'package:innova_ito/providers/acceso_formulario_prov.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/theme/app_tema.dart';

class RecuperarContrasenaScreen extends StatefulWidget {
  static const String name = 'RecuperarContrasena';
  RecuperarContrasenaScreen({Key? key}) : super(key: key);

  @override
  State<RecuperarContrasenaScreen> createState() => _RecuperarContrasenaScreenState();
}

class _RecuperarContrasenaScreenState extends State<RecuperarContrasenaScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool camposLlenos = true;
  TextEditingController correo = TextEditingController();
  String contrasenaHash = '';
  String contrasena = '';
  List<UsuarioData> dataUser = [];

  Future acceso() async {
    String url = 'https://evarafael.com/Aplicacion/rest/login.php';
    var response = await http.post(Uri.parse(url), body: {
      "Nombre_usuario": correo.text,
    });

    var data = json.decode(response.body);
    if (data == "Realizado") {
      print('buscando usuario...');
      getUser(correo.text);
      enviar();
      
      //Navigator.pushReplacementNamed(context, 'menu_lateral');
    }else{
      QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      title: 'Correo no existente',
                                      text:
                                          'Verifique el correo electronico proporcionado',
                                      confirmBtnText: 'Hecho',
                                      confirmBtnColor: AppTema.pizazz,
                                    );

    }
  }

  Future enviar() async {
    String url = 'https://evarafael.com/Aplicacion/rest/update_usuario.php';
    var response = await http.post(Uri.parse(url), body: {
      "id": correo.text,
      "nuevoValor": contrasenaHash,
    });

    var data = json.decode(response.body);
    if (data['success']) {
      String nombre = Apoyo.capitalizar(dataUser[0].nombrePersona.toString());
      String ap1 = Apoyo.capitalizar(dataUser[0].apellido1.toString());
      String ap2 = Apoyo.capitalizar(dataUser[0].apellido2.toString());
      Correo.recuperacionContrasena(
          context,
          correo.text.toUpperCase(),
          contrasena,
          nombre,
          ap1,
          ap2);
      
      //Navigator.pushReplacementNamed(context, 'menu_lateral');
    }else{
      QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      title: 'Intente mas tarde',
                                      text:
                                          'Problemas al enviar el correo electronico.',
                                      confirmBtnText: 'Hecho',
                                      confirmBtnColor: AppTema.pizazz,
                                    );

    }
  }

   Future<void> getUser(String correo) async {
    String url = 'https://evarafael.com/Aplicacion/rest/get_dataUser.php';
    var response = await http.post(Uri.parse(url), body: {
      "Nombre_usuario": correo,
    });
    if (response.statusCode == 200) {
      dataUser = usuarioDataFromJson(response.body);
      
    } else {
      print('nisiquiera carga');
    }
  }

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
                    'Recuperar cuenta',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: AppTema.balticSea,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Por favor, cómpartenos tu correo registrado en el evento para recuperar tu contraseña.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: AppTema.balticSea,
                        fontSize: 15,
                        fontStyle: FontStyle.italic
                        ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Form(
                        key: _formKey,
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
                            // onChanged: (value) => accesoFormulario.correo = value,
                            validator: (value) {
                              return RegexUtil.correo.hasMatch(value ?? '')
                                  ? null
                                  : 'El valor ingresado no es un correo.';
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
                                      'Enviar',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                onPressed: () async {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                       contrasena = Generar.contrasenaAleatoria();
                                  contrasenaHash =
                                      Generar.hashContrasena(contrasena);
                                      acceso();
                                      
                                
                                }),
                          
                        ])),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
