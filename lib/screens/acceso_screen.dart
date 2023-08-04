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
import 'package:innova_ito/widgets/widgets.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/theme/app_tema.dart';

class AccesoScreen extends StatefulWidget {
  static const String name = 'acceso';
  AccesoScreen({Key? key}) : super(key: key);

  @override
  State<AccesoScreen> createState() => _AccesoScreenState();
}

class _AccesoScreenState extends State<AccesoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool camposLlenos = true;
  TextEditingController correo = TextEditingController();
  TextEditingController contrasena = TextEditingController();

  List lista = [];
  List<UsuarioData> dataUser = [];

  String contrasenaHash = '';
  String matricula = '';

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

  Future<String> getMatricula(String idpersona) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/get_estudiante.php?Id_persona=$idpersona';
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      var datos = jsonDecode(response.body);
      matricula = datos[0]['Matricula'].toString();
      print(matricula);
      await Future.delayed(Duration(seconds: 2));
      return matricula;
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
      print('buscando usuario...');
      getUser(correo.text);
    }
  }

  Future<void> getUser(String correo) async {
    String url = 'https://evarafael.com/Aplicacion/rest/get_dataUser.php';
    var response = await http.post(Uri.parse(url), body: {
      "Nombre_usuario": correo,
    });
    if (response.statusCode == 200) {
      dataUser = usuarioDataFromJson(response.body);
      getMatricula(dataUser[0].idUsuario);
      await Future.delayed(const Duration(seconds: 3), () {
        print('no encontrado');
        context.goNamed('menu_lateral');
      });
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
                    'Acceso',
                    style: TextStyle(
                        color: AppTema.balticSea,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
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
                          TextFormField(
                            controller: contrasena,
                            autocorrect: false,
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            decoration: InputDecorations.accesoInputDecoration(
                                hintText: '******',
                                labelText: 'Contraseña',
                                prefixIcon: Icons.key),
                            //onChanged: (value) => accesoFormulario.contrasena = value,
                            validator: (value) {
                              return RegexUtil.contrasena.hasMatch(value ?? '')
                                  ? null
                                  : 'No es una contraseña valida.';
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Consumer(builder: (context, ref, child) {
                            final nombreUsuarioNotifier =
                                ref.watch(nombreUsuarioLogin);

                            return MaterialButton(
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
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  setState(() {
                                    camposLlenos =
                                        _formKey.currentState!.validate();
                                    print(camposLlenos);
                                  });
                                  if (camposLlenos) {
                                    String pass = await getUsuario(correo.text);

                                    bool comparado = Generar.compararContrasena(
                                        contrasena.text.toString(), pass);
                                    print(comparado);
                                    if (comparado == true) {
                                      acceso();
                                      Future.delayed(Duration(seconds: 3), () {
                                        //obtener iniciales del nombre
                                        String ini = Apoyo.obtenerIniciales(
                                            dataUser[0]
                                                .nombrePersona
                                                .toString());
                                        //obtener nombre completo del usuario
                                        String nombreUsuario =
                                            Apoyo.capitalizar(dataUser[0]
                                                    .nombrePersona
                                                    .toString() +
                                                ' ' +
                                                dataUser[0]
                                                    .apellido1
                                                    .toString() +
                                                ' ' +
                                                dataUser[0]
                                                    .apellido2
                                                    .toString());
                                        //obtener rol del usuario
                                        String rolUsuario = Apoyo.capitalizar(
                                            dataUser[0].nombreRol.toString());
                                        //guardar datos en el riverpood
                                        //Guardar id de persona usuaurio y asesor en provider
                                        ref
                                            .read(idUsuarioLogin.notifier)
                                            .update((state) => dataUser[0]
                                                .idUsuario
                                                .toString());
                                        ref
                                            .read(nombreUsuarioLogin.notifier)
                                            .update((state) => nombreUsuario);
                                        ref
                                            .read(nombreRolLogin.notifier)
                                            .update((state) => rolUsuario);
                                        ref
                                            .read(inicialesUsuario.notifier)
                                            .update((state) => ini);
                                        ref
                                            .read(matriculaProvider.notifier)
                                            .update((state) => matricula);
                                      });
                                    }
                                  } else {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      title: 'Datos incorrectos',
                                      text:
                                          'Verifique su correo electronico y contraseña',
                                      confirmBtnText: 'Hecho',
                                      confirmBtnColor: AppTema.pizazz,
                                    );
                                  }
                                });
                          }),
                        ])),
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
                        if (barcodeScanRes == '20230531') {
                          //print(barcodeScanRes);
                          context.pushNamed('registro_usuario_asesor');
                        }
                        if (barcodeScanRes == '202305312') {
                          //print(barcodeScanRes);
                          context.pushNamed('registro_usuario_lider');
                        }
                      }),
                  TextButton(
                      child: const Text(
                        '¿Olvidó su contraseña?',
                        style: TextStyle(
                            color: Color.fromRGBO(46, 45, 47, 0.8),
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        context.pushNamed('RecuperarContrasena');
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
