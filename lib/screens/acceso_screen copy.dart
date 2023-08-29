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
  List folio = [];

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
      //await Future.delayed(Duration(seconds: 2));
      return matricula;
    } else {
      return '';
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
      return matricula;
    } else {
      return '';
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
      return '';
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
      // print('encontrado');
      // context.goNamed('inicioLider');
      Future.delayed(const Duration(seconds: 2), () {
        print('encontrado');
        context.goNamed('inicioLider');
      });
    } else {
      print('nisiquiera carga');
    }
  }

  //oBTENER FOLIO DEL PROYECTO EN EL QUE PARTICIPA EL ESTUDIANTE
  Future<void> getFolioProyecto(String matricula) async {
    String url =
        'https://evarafael.com/Aplicacion/rest/get_Folio.php?Matricula=$matricula';
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      folio = jsonDecode(response.body);
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
                                    String pass = await getUsuario(correo.text);
                                    print('Contraseña encontrada: $pass');
                                    bool comparado = Generar.compararContrasena(
                                        contrasena.text.toString(), pass);
                                    print('contraseña igual : $comparado');
                                    if (comparado == true) {
                                      acceso();
                                      Future.delayed(Duration(seconds: 1), () {
                                        //obtener iniciales del nombre

                                        ref
                                            .read(juradoIDProvider.notifier)
                                            .update((state) => getMatricula(
                                                    dataUser[0].idUsuario)
                                                .toString());

                                        getMatricula(dataUser[0].idUsuario);
                                        getJurado(dataUser[0].idUsuario);
                                        getAsesor(dataUser[0].idUsuario);

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

                                        //print('jurado id : $juradoID');
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
                                        ref
                                            .read(folioProyectoUsuarioLogin
                                                .notifier)
                                            .update(
                                                (state) => folio[0]['Folio']);

                                        ref
                                            .read(juradoIDProvider.notifier)
                                            .update((state) => juradoID);
                                        print('jurado id : $juradoID');

                                        ref
                                            .read(asesorIDProvider.notifier)
                                            .update((state) => asesorID);
                                      });
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
                        print(
                            'codigoooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo:$barcodeScanRes');
                        if (barcodeScanRes == '202305313') {
                          print(barcodeScanRes);
                          context.pushReplacementNamed('registroUsuarioJurado');
                        }
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
