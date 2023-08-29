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
  String asesorID = '';
  String juradoID = '';
  // List folio = [];
  String folio = '';

  Future<String> getMatricula(String idpersona) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/get_estudiante.php?Id_persona=$idpersona';
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      var datos = jsonDecode(response.body);
      matricula = datos[0]['Matricula'].toString();
      print(matricula);
      //await Future.delayed(Duration(seconds: 2));
      return matricula;
    } else {
      return 'SN';
    }
  }

  Future<String> getAsesor(String idpersona) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/get_asesor.php?Id_persona=$idpersona';
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      var datos = jsonDecode(response.body);
      asesorID = datos[0]['Id_asesor'].toString();
      print(asesorID);
      //await Future.delayed(Duration(seconds: 2));
      return asesorID;
    } else {
      return 'SN';
    }
  }

  Future<String> getJurado(String idpersona) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/get_jurado.php?Id_persona=$idpersona';
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      var datos = jsonDecode(response.body);
      juradoID = datos[0]['Id_jurado'].toString();
      print(juradoID);
      //await Future.delayed(Duration(seconds: 2));
      return juradoID;
    } else {
      return 'SN';
    }
  }

  List<DatosUsuariosLogin> datosU = [];

  Future<bool> getUsuarioLogin(String correo) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/get_datosUsuario.php?Nombre_usuario=$correo';
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      datosU = datosUsuariosLoginFromJson(response.body);
      return true;
    } else {
      return false;
    }
  }

  //oBTENER FOLIO DEL PROYECTO EN EL QUE PARTICIPA EL ESTUDIANTE
  Future<String> getFolioProyecto(String matricula) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/get_Folio.php?Matricula=$matricula';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var responseData = response.body;

      if (responseData.isNotEmpty) {
        var datos = jsonDecode(responseData);

        if (datos is Map && datos.containsKey("message")) {
          return 'SN';
        } else {
          folio = datos[0]['Folio'].toString();
          return folio;
        }
      } else {
        //print('La respuesta está vacía.');
        return 'SN';
      }
    } else {
      //print('Error en la solicitud HTTP: ${response.statusCode}');
      return 'SN';
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
                                hintText: 'Correo electrónico',
                                labelText: 'Correo electrónico',
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
                                  : 'No es una contraseña valida ortográfico.';
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
                                    bool buscar =
                                        await getUsuarioLogin(correo.text);

                                    print('buscar: $buscar');
                                    if (buscar) {
                                      print('si fue buscado');
                                      if (datosU.isEmpty) {
                                        print('no existe');
                                      } else {
                                        print('si existe');

                                        String ini = Apoyo.obtenerIniciales(
                                            datosU.first.nombrePersona);
                                        String nombreUsuario =
                                            Apoyo.capitalizar(
                                                datosU.first.nombrePersona +
                                                    ' ' +
                                                    datosU.first.apellido1 +
                                                    ' ' +
                                                    datosU.first.apellido2);
                                        String rolUsuario = Apoyo.capitalizar(
                                            datosU.first.nombreRol);

                                        ref
                                            .read(idUsuarioLogin.notifier)
                                            .update((state) =>
                                                datosU.first.idUsuario);
                                        ref
                                            .read(nombreUsuarioLogin.notifier)
                                            .update((state) => nombreUsuario);
                                        ref
                                            .read(nombreRolLogin.notifier)
                                            .update((state) => rolUsuario);
                                        ref
                                            .read(inicialesUsuario.notifier)
                                            .update((state) => ini);

                                        if (datosU.first.nombreRol
                                                .toLowerCase() ==
                                            'jurado interno') {
                                          String juraId = await getJurado(
                                              datosU.first.idUsuario);
                                          ref
                                              .read(juradoIDProvider.notifier)
                                              .update((state) => juraId);
                                          print(juraId);
                                          context.goNamed('inicioLider');
                                        }

                                        if (datosU.first.nombreRol
                                                .toLowerCase() ==
                                            'asesor') {
                                          String aseId = await getAsesor(
                                              datosU.first.idUsuario);
                                          ref
                                              .read(asesorIDProvider.notifier)
                                              .update((state) => aseId);

                                          context.goNamed('inicioLider');
                                        }
                                        if (datosU.first.nombreRol
                                                .toLowerCase() ==
                                            'estudiante lider') {
                                          String matID = await getMatricula(
                                              datosU.first.idUsuario);
                                          ref
                                              .read(matriculaProvider.notifier)
                                              .update((state) => matID);
                                          String fol =
                                              await getFolioProyecto(matID);

                                          ref
                                              .read(folioProyectoUsuarioLogin
                                                  .notifier)
                                              .update((state) => fol);
                                          context.goNamed('inicioLider');
                                        }
                                        if (datosU.first.nombreRol
                                                .toLowerCase() ==
                                            'coordinador local') {
                                          // String aseId = await getAsesor(
                                          //     datosU.first.idUsuario);
                                          // ref
                                          //     .read(asesorIDProvider.notifier)
                                          //     .update((state) => aseId);

                                          context.goNamed('inicioLider');
                                        }
                                        if (datosU.first.nombreRol
                                                .toLowerCase() ==
                                            'administrador') {
                                          context.goNamed('inicioLider');
                                        }
                                      }
                                    }
                                  } else {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      title: 'Datos incorrectos',
                                      text:
                                          'Verifique su correo electrónico y contraseña',
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
                        if (barcodeScanRes == '202305313') {
                          print(barcodeScanRes);
                          context.pushNamed('registroUsuarioJurado');
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
