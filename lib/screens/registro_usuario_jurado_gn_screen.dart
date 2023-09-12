import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/helpers/helpers.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<bool> existenteJGn(String idPersona) async {
  String url = '${dotenv.env['HOST_REST']}existePersona.php';
  var response = await http.post(Uri.parse(url), body: {
    'Id_persona': idPersona,
  });

  var data = json.decode(response.body);
  if (data == "Realizado") {
    return true;
  } else {
    return false;
  }
}

Future<bool> agregarJuradoGn(
  BuildContext context,
  String id,
  String nombre,
  String ap1,
  String ap2,
  String telefono,
  String correo,
  String ine,
  String curp,
  String contrasena,
  String contrasenahs,
  String rol,
  String idj,
  String rfc,
) async {
  var url = '${dotenv.env['HOST_REST']}agregar_jurado.php';
  try {
    var response = await http.post(Uri.parse(url), body: {
      'Id_persona': id,
      'Nombre_persona': nombre,
      'Apellido1': ap1,
      'Apellido2': ap2,
      'Telefono': telefono,
      'Correo_electronico': correo,
      'Num_ine': ine,
      'Curp': curp,
      'Id_usuario': id,
      'Nombre_usuario': correo,
      'Contrasena': contrasenahs,
      'Id_rol': rol,
      'Id_jurado': 'JUR$idj',
      'rfc': rfc
    });

    if (response.statusCode == 200) {
      Correo.registroJurado(context, correo.toUpperCase(), contrasena,
          nombre.toUpperCase(), ap1.toUpperCase(), ap2.toUpperCase());

      return true;
    } else {
      return false;
      //print('La solicitud no fue exitosa: ${response.statusCode}');
    }
  } catch (error) {
    return false;
    //print('Error al realizar la solicitud: $error');
  }
}

final fechaSeleccionadaRUJGnProv = StateProvider<DateTime?>((ref) => null);

class RegistroUsuarioJuradoGnScreen extends ConsumerWidget {
  static const String name = 'registroUsuarioJurado_gn';

  RegistroUsuarioJuradoGnScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String id = '';
  DateTime? fechaSeleccionada;
  DateTime fecha = DateTime(0000, 00, 00);

  TextEditingController cNombre = TextEditingController();
  TextEditingController cApellidoP = TextEditingController();
  TextEditingController cApellidoM = TextEditingController();
  TextEditingController cRfc = TextEditingController();
  TextEditingController cCurp = TextEditingController();
  TextEditingController cIne = TextEditingController();
  TextEditingController cCorreo = TextEditingController();
  TextEditingController cNumero = TextEditingController();
  String genero = '';
  String eNacimiento = '';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cGenero = ref.watch(generoProv);
    final camposLlenos = ref.watch(camposLlenosProv);
    final fechasRUJ = ref.watch(fechaSeleccionadaRUJGnProv);

    String contrasena = '';
    String contrasenaHash = '';

    Future _mostrarDatePickerRUJ(context, ref) async {
      final seleccion = await showDatePicker(
        context: context,
        locale: const Locale("es", "ES"),
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppTema.pizazz,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    primary: AppTema.pizazz // button text color
                    ),
              ),
            ),
            child: child!,
          );
        },
      );

      if (seleccion != null && seleccion != fechaSeleccionada) {
        fechaSeleccionada = seleccion;
        fecha = DateTime(seleccion.year, seleccion.month, seleccion.day);
        //print(fecha);
        ref.read(fechaSeleccionadaRUJGnProv.notifier).update((state) => fecha);
      }
    }

    return Scaffold(
        body: FondoGn(
            tituloPantalla: 'Registro de jurado',
            fontSize: 20,
            widget: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Ingrese datos del evaluador',
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
                          const SizedBox(height: 20),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: cNombre,
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
                                  : 'Nombre no válido.';
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: cApellidoP,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese primer apellido',
                              labelText: 'Primer apellido',
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: cApellidoM,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese segundo apellido',
                              labelText: 'Segundo apellido',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Estado de nacimiento',
                              style: TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            hint: const Text(
                              'Seleccione estado de nacimiento',
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            isExpanded: true,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            value: null,
                            onChanged: (value) {
                              eNacimiento = value.toString();
                              // setState(() {
                              //  // selectedState = newValue;
                              // });
                            },
                            items: estadosAbreviaturas.keys
                                .map<DropdownMenuItem<String>>((String estado) {
                              return DropdownMenuItem<String>(
                                value: estado,
                                child: Text(
                                  estado,
                                  overflow: TextOverflow.visible,
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            // padding: EdgeInsets.only(right: 2.0),
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Género',
                              style: TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField<String>(
                            hint: const Text(
                              'Seleccione una opción',
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            isExpanded: true,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            //value: null,
                            onChanged: (value) {
                              genero = value.toString();
                            },
                            items: generos.map<DropdownMenuItem<String>>(
                                (Map<String, String> genero) {
                              return DropdownMenuItem<String>(
                                value: genero['abreviatura'],
                                child: Text(genero['nombre']!),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            child: Text(
                              fechaSeleccionada != null
                                  ? 'Fecha seleccionada: ${DateFormat('yyyy-MM-dd').format(fecha)}'
                                  : 'Seleccione fecha de nacimiento',
                            ),
                            onPressed: () =>
                                _mostrarDatePickerRUJ(context, ref),
                            // fechaSeleccionada != null
                            //     ? null
                            //     : () => _mostrarDatePickerRUJ(context, ref),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            maxLength: 18,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: cCurp,
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese CURP',
                              labelText: 'CURP',
                            ),
                            validator: (value) {
                              //String gen = cGenero

                              int curpLength = value?.length ?? 0;
                              if (RegexUtil.curp.hasMatch(value ?? '')) {
                                // Genera la CURP para compararla
                                // String fe = DateFormat('yyyy-MM-dd').format(fecha);
                                String curpGenerada =
                                    CurpGenerator.generateCurp(
                                        cNombre.text,
                                        cApellidoP.text,
                                        cApellidoM.text,
                                        fecha,
                                        genero,
                                        eNacimiento);

                                //print(curpGenerada);
                                //print(fecha);
                                String value1 =
                                    value.toString().substring(0, 14);
                                String value2 =
                                    value.toString().substring(15, 16);
                                String parte1g = curpGenerada.substring(0, 14);
                                String parte2g = curpGenerada.substring(15, 16);
                                //print(curpGenerada.substring(0, 14));

                                // Compara la CURP ingresada con la generada
                                if (curpLength == 18) {
                                  //  print(o)
                                  if (value1 == parte1g && value2 == parte2g) {
                                    return null;
                                  } else {
                                    return 'La CURP ingresada no coincide con la generada.';
                                  } // CURP válida
                                } else {
                                  return 'La CURP ingresada no coincide con la generada.';
                                }
                              } else {
                                return 'La CURP ingresada no es válida.';
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            maxLength: 13,
                            controller: cRfc,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese RFC',
                              labelText: 'RFC',
                            ),
                            validator: (value) {
                              int curpLength = value?.length ?? 0;
                              if (RegexUtil.rfc.hasMatch(value ?? '')) {
                                // Genera la CURP para compararla
                                String curpGenerada =
                                    CurpGenerator.generateCurp(
                                        cNombre.text,
                                        cApellidoP.text,
                                        cApellidoM.text,
                                        fecha,
                                        genero,
                                        eNacimiento);

                                // Compara la CURP ingresada con la generada
                                if (curpLength == 13) {
                                  if (curpGenerada.substring(0, 10) ==
                                      cRfc.text.substring(0, 10)) {
                                    return null;
                                  } else {
                                    return 'El RFC ingresado no coincide con la generado.';
                                  } // CURP válida
                                } else {
                                  return 'El RFC ingresado no coincide con la generado.';
                                }
                              } else {
                                return 'El rfc ingresado no es válido.';
                              }
                            },
                            //onChanged: (value) => accesoFormulario.correo = value,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            maxLength: 13,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: cIne,
                            autocorrect: false,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese No. De credencial INE',
                              labelText: 'No. Cred. INE',
                            ),
                            validator: (value) {
                              return RegexUtil.ine.hasMatch(value ?? '')
                                  ? null
                                  : 'Credencial no válida.';
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: cCorreo,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese correo electrónico',
                              labelText: 'Correo electrónico',
                            ),
                            validator: (value) {
                              return RegexUtil.correo.hasMatch(value ?? '')
                                  ? null
                                  : 'Correo no válido.';
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            maxLength: 10,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: cNumero,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese número telefónico',
                              labelText: 'Número telefónico',
                            ),
                            validator: (value) {
                              return RegexUtil.telefono.hasMatch(value ?? '')
                                  ? null
                                  : 'Solo se aceptan números.';
                            },
                          ),
                          const SizedBox(height: 20),
                          const SizedBox(height: 20),
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
                                // ref.read(camposLlenosProv.notifier).update(
                                //     (state) =>
                                //         _formKey.currentState!.validate());
                                if (_formKey.currentState!.validate() &&
                                    fecha != DateTime(0000, 00, 00) &&
                                    genero != '' &&
                                    eNacimiento != '') {
                                  String idPersona = Generar.idPersona(
                                      cNombre.text.toUpperCase(),
                                      cApellidoP.text.toUpperCase(),
                                      cApellidoM.text.toUpperCase(),
                                      cCorreo.text.toUpperCase());
                                  bool result = await existenteJGn(idPersona);
                                  //print('1');
                                  if (result) {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      title: 'Usuario existente',
                                      confirmBtnText: 'Hecho',
                                      confirmBtnColor: AppTema.pizazz,
                                    );
                                  } else {
                                    do {
                                      contrasena =
                                          Generar.contrasenaAleatoria();
                                    } while (!RegexUtil.contrasena
                                        .hasMatch(contrasena));

                                    print('Contraseña generada: $contrasena');
                                    //contrasena = Generar.contrasenaAleatoria();
                                    contrasenaHash =
                                        Generar.hashContrasena(contrasena);
                                    String idju =
                                        const Uuid().v4().substring(0, 8);
                                    bool agregado = await agregarJuradoGn(
                                        context,
                                        idPersona,
                                        cNombre.text.toUpperCase(),
                                        cApellidoP.text.toUpperCase(),
                                        cApellidoM.text.toUpperCase(),
                                        cNumero.text,
                                        cCorreo.text,
                                        cIne.text,
                                        cCurp.text.toUpperCase(),
                                        contrasena,
                                        contrasenaHash,
                                        'ROL04',
                                        idju,
                                        cRfc.text.toUpperCase());

                                    if (agregado) {
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.success,
                                        title: 'Jurado agregado',
                                        confirmBtnText: 'Hecho',
                                        confirmBtnColor: AppTema.pizazz,
                                        onConfirmBtnTap: () {
                                          context
                                              .pushReplacementNamed('acceso');
                                        },
                                      );
                                    } else {
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.error,
                                        title: 'Ocurrió un error',
                                        confirmBtnText: 'Hecho',
                                        confirmBtnColor: AppTema.pizazz,
                                        onConfirmBtnTap: () {
                                          context.pop();
                                        },
                                      );
                                    }
                                  }
                                } else {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.warning,
                                    title: 'Existen campos vacíos',
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
