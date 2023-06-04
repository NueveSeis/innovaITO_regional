import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;

import 'package:innova_ito/theme/app_tema.dart';

import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:innova_ito/helpers/helpers.dart';

class RegistroUsuarioLiderScreen extends StatefulWidget {
  static const String name = 'registro_usuario_lider';
  const RegistroUsuarioLiderScreen({super.key});

  @override
  State<RegistroUsuarioLiderScreen> createState() =>
      _RegistroUsuarioLiderScreenState();
}

class _RegistroUsuarioLiderScreenState
    extends State<RegistroUsuarioLiderScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nivel = TextEditingController();
  TextEditingController matricula = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController apellidoP = TextEditingController();
  TextEditingController apellidoM = TextEditingController();
  TextEditingController correo = TextEditingController();
  String contrasena = '';
  String id = '';
  String contrasenaHash = '';
  bool existePersona = false;
  String idNivel = '';
  bool camposLlenos = true;

  Future agregarPersona() async {
    var url = 'https://evarafael.com/Aplicacion/rest/agregarLider.php';
    await http.post(Uri.parse(url), body: {
      'Id_persona': id,
      'Nombre_persona': nombre.text.toUpperCase(),
      'Apellido1': apellidoP.text.toUpperCase(),
      'Apellido2': apellidoM.text.toUpperCase(),
      'Correo_electronico': correo.text.toUpperCase(),
      'Id_usuario': id,
      'Nombre_usuario': correo.text.toUpperCase(),
      'Contrasena': contrasenaHash,
      'Id_rol': 'ROL02',
      'Matricula': matricula.text.toUpperCase(),
      'Id_nivel': idNivel
    });
  }

  Future<String> obtenerNivelLider(String nivel) async {
    var url =
        'https://evarafael.com/Aplicacion/rest/buscar_nivel.php?Nombre_nivel=$nivel';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var datos = jsonDecode(response.body);
      String miString = datos[0]['Id_nivel'].toString();
      return miString;
    } else {
      return '';
      print('Error al obtener datos de la API');
    }
  }

  Future existente() async {
    String url = 'https://evarafael.com/Aplicacion/rest/existePersona.php';
    var response = await http.post(Uri.parse(url), body: {
      'Id_persona': id,
    });

    var data = json.decode(response.body);
    if (data == "Realizado") {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Usuario existente',
        confirmBtnText: 'Hecho',
        confirmBtnColor: AppTema.pizazz,
      );
    } else {
      agregarPersona();
      Correo.registroLider(
          context,
          correo.text.toUpperCase(),
          contrasena,
          nombre.text.toUpperCase(),
          apellidoP.text.toUpperCase(),
          apellidoM.text.toUpperCase());
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    //final registroLider = Provider.of<RegistroLiderProv>(context);

    return Scaffold(
        body: Fondo(
            tituloPantalla: 'Registro lider de proyecto',
            fontSize: 20,
            widget: Column(
              children: [
                const SizedBox(height: 50),
                Text(
                  'Ingrese datos del estudiante',
                  style: TextStyle(
                      color: AppTema.balticSea,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Form(
                      //autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          DropdownButtonFormField(
                              value: 'Seleccione una opción',
                              style: const TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Seleccione una opción',
                                  child: Text('Seleccione una opción'),
                                ),
                                DropdownMenuItem(
                                  value: 'Licenciatura',
                                  child: Text('Licenciatura'),
                                ),
                                DropdownMenuItem(
                                  value: 'Posgrado',
                                  child: Text('Posgrado'),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  nivel.text = value.toString();
                                });

                                print(nivel);
                              }),
                          const SizedBox(height: 20),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: matricula,
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese matricula',
                              labelText: 'Matricula',
                            ),
                            validator: (value) {
                              return RegexUtil.matricula.hasMatch(value ?? '')
                                  ? null
                                  : 'Matricula no valida.';
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: nombre,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese nombre(s)',
                              labelText: 'Nombre(s)',
                            ),
                            //onChanged: (value) => registroLider.nombre = value,
                            validator: (value) {
                              return RegexUtil.nombres.hasMatch(value ?? '')
                                  ? null
                                  : 'Nombre no valido.';
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: apellidoP,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese apellido paterno',
                              labelText: 'Apellido paterno',
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: apellidoM,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese apellido materno',
                              labelText: 'Apellido materno',
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: correo,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese correo electronico',
                              labelText: 'Correo electronico',
                            ),
                            validator: (value) {
                              return RegexUtil.correoEdu.hasMatch(value ?? '')
                                  ? null
                                  : 'Solo se acepta correo institucional.';
                            },
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: ElevatedButton(
                              child: const Center(
                                  //height: 50,
                                  child: Text(
                                'Registrar',
                                style: TextStyle(
                                    color: AppTema.grey100, fontSize: 25),
                              )),
                              onPressed: () async {
                                setState(() {
                                  camposLlenos =
                                      _formKey.currentState!.validate();
                                });
                                if (camposLlenos) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  idNivel = await obtenerNivelLider(
                                      nivel.text.toString());
                                  id = Generar.idPersona(
                                      nombre.text.toUpperCase(),
                                      apellidoP.text.toUpperCase(),
                                      apellidoM.text.toLowerCase(),
                                      correo.text.toUpperCase());
                                  contrasena = Generar.contrasenaAleatoria();
                                  contrasenaHash =
                                      Generar.hashContrasena(contrasena);
                                  existente();
                                } else {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.warning,
                                    title: 'Cuidado',
                                    text: 'Rellena los campos faltantes',
                                    confirmBtnText: 'Hecho',
                                    confirmBtnColor: AppTema.pizazz,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            )));
  }
}
