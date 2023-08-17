import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:innova_ito/helpers/helpers.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:innova_ito/models/models.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:go_router/go_router.dart';

class RegistroUsuarioAsesorScreen extends StatefulWidget {
  static const String name = 'registro_usuario_asesor';
  const RegistroUsuarioAsesorScreen({super.key});

  @override
  State<RegistroUsuarioAsesorScreen> createState() =>
      _RegistroUsuarioAsesorScreenState();
}

class _RegistroUsuarioAsesorScreenState
    extends State<RegistroUsuarioAsesorScreen> {
  @override
  void initState() {
    obtenerTipoTec();
    //obtenerTecnologico();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController cTitulo = TextEditingController();
  TextEditingController cNombres = TextEditingController();
  TextEditingController cApellido1 = TextEditingController();
  TextEditingController cApellido2 = TextEditingController();
  TextEditingController cCorreo = TextEditingController();
  TextEditingController cCurp = TextEditingController();
  TextEditingController cRfc = TextEditingController();
  TextEditingController cNumIne = TextEditingController();
  TextEditingController cTelefono = TextEditingController();
  TextEditingController cLicenciatura = TextEditingController();
  TextEditingController cMaestria = TextEditingController();
  TextEditingController cDoctorado = TextEditingController();
  late String tipoAsesor;
  //late String departamentoAdscrito;
  final jobRoleCtrl = TextEditingController();
  bool camposLlenos = true;
  bool licen = false;
  bool maes = false;
  bool doc = false;
  bool cargando = false;
  bool cargando2 = false;
  bool cargando3 = false;
  List<Tecnologico> tecnologicoM = [];
  List<TipoTecnologico> tipoTec = [];
  List<Departamento> departamento = [];
  String valueTipo = '';
  String valueClaveTec = '';
  String valueDepartamento = '';
  late String idPersona;
  late String contrasena;
  late String contrasenaHash;
  String eNacimiento = '';
  String genero = '';

  Future agregarAsesor() async {
    var url = 'https://evarafael.com/Aplicacion/rest/agregarAsesor.php';
    await http.post(Uri.parse(url), body: {
      'Id_persona': idPersona,
      'Nombre_persona': cNombres.text.toUpperCase(),
      'Apellido1': cApellido1.text.toUpperCase(),
      'Apellido2': cApellido2.text.toUpperCase(),
      'Telefono': cTelefono.text,
      'Correo_electronico': cCorreo.text.toUpperCase(),
      'Num_ine': cNumIne.text,
      'Curp': cCurp.text.toUpperCase(),
      'Id_usuario': 'USU$idPersona',
      'Nombre_usuario': cCorreo.text,
      'Contrasena': contrasenaHash,
      'Id_rol': 'ROL03',
      'Id_asesor': 'ASE$idPersona',
      'RFC': cRfc.text.toUpperCase(),
      'Abreviatura_profesional': cTitulo.text,
      'Licenciatura': cLicenciatura.text.toUpperCase(),
      'Maestria': cMaestria.text.toUpperCase(),
      'Doctorado': cDoctorado.text.toUpperCase(),
      'Id_departamento': valueDepartamento,
      'Id_cargoAsesor': tipoAsesor,
    });
  }

  Future existente() async {
    String url = 'https://evarafael.com/Aplicacion/rest/existePersona.php';
    var response = await http.post(Uri.parse(url), body: {
      'Id_persona': idPersona,
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
      agregarAsesor();
      Correo.registroAsesor(
          context,
          cCorreo.text.toUpperCase(),
          contrasena,
          cNombres.text.toUpperCase(),
          cApellido1.text.toUpperCase(),
          cApellido1.text.toUpperCase());
      context.pop();
    }
  }

  Future obtenerDepartamento() async {
    var url =
        'https://evarafael.com/Aplicacion/rest/get_departamento.php?Clave_tecnologico=$valueClaveTec';
    var response = await http.get(Uri.parse(url));
    departamento = departamentoFromJson(response.body);
    //print(tecnologicoM[0].nombreTecnologico);
    setState(() {
      cargando3 = true;
    });
  }

  Future obtenerTecnologico() async {
    var url =
        'https://evarafael.com/Aplicacion/rest/get_tecnologico.php?Id_tipoTec=$valueTipo';
    var response = await http.get(Uri.parse(url));
    tecnologicoM = tecnologicoFromJson(response.body);
    setState(() {
      cargando2 = true;
    });
  }

  Future obtenerTipoTec() async {
    var url = 'https://evarafael.com/Aplicacion/rest/get_tipoTec.php';
    var response = await http.get(Uri.parse(url));
    tipoTec = tipoTecnologicoFromJson(response.body);
    //print(tipoTec[0].tipoTec);
    setState(() {
      cargando = true;
    });
  }

  final fechaSeleccionadaRUASProv = StateProvider<DateTime?>((ref) => null);

  @override
  Widget build(BuildContext context) {
    DateTime? fechaSeleccionada;
    DateTime fecha = DateTime(0000, 00, 00);

    Future _mostrarDatePicker(context, ref) async {
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

        ref.read(fechaSeleccionadaRUASProv.notifier).update((state) => fecha);
      }
    }

    Widget _Licenciatura() {
      return TextFormField(
        controller: cLicenciatura,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autocorrect: false,
        keyboardType: TextInputType.text,
        style: const TextStyle(
            color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
        decoration: InputDecorations.registroLiderDecoration(
          hintText: 'Ingrese licenciatura',
          labelText: 'Licenciatura',
        ),
        validator: (value) {
          return RegexUtil.carrera.hasMatch(value ?? '')
              ? null
              : 'Los datos ingresados no son validos.';
        },
      );
    }

    Widget _Maestria() {
      return TextFormField(
        controller: cMaestria,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
            color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
        decoration: InputDecorations.registroLiderDecoration(
          hintText: 'Ingrese Maestria',
          labelText: 'Maestria',
        ),
        validator: (value) {
          return RegexUtil.carrera.hasMatch(value ?? '')
              ? null
              : 'Los datos ingresados no son validos.';
        },
        //onChanged: (value) => accesoFormulario.correo = value,
      );
    }

    Widget _Doctorado() {
      return TextFormField(
        controller: cDoctorado,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
            color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
        decoration: InputDecorations.registroLiderDecoration(
          hintText: 'Ingrese Doctorado',
          labelText: 'Doctorado',
        ),
        validator: (value) {
          return RegexUtil.carrera.hasMatch(value ?? '')
              ? null
              : 'Los datos ingresados no son validos.';
        },
      );
    }

    return Scaffold(
        body: Fondo(
      tituloPantalla: 'Registro de asesor',
      fontSize: 25,
      widget: Column(
        children: [
          const SizedBox(height: 50),
          const Text(
            'Ingrese datos del asesor',
            style: TextStyle(
                color: AppTema.balticSea,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    cargando
                        ? _tipoTecnologico(tipoTec)
                        : const CircularProgressIndicator(),
                    const SizedBox(height: 20),
                    cargando2
                        ? _institutoPertenencia(tecnologicoM)
                        : const SizedBox(),
                    const SizedBox(height: 20),
                    cargando3
                        ? _departamentoAdscrito(departamento)
                        : const SizedBox(),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: cTitulo,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(
                          color: AppTema.bluegrey700,
                          fontWeight: FontWeight.bold),
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecorations.registroLiderDecoration(
                        hintText: 'Ingrese su titulo',
                        labelText: 'Titulo (Lic., M.C., Dr.)',
                      ),
                      validator: (value) {
                        return RegexUtil.titulo.hasMatch(value ?? '')
                            ? null
                            : 'La abreviatura no es valida.';
                      },
                      //onChanged: (value) => accesoFormulario.correo = value,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: cNombres,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(
                          color: AppTema.bluegrey700,
                          fontWeight: FontWeight.bold),
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecorations.registroLiderDecoration(
                        hintText: 'Ingrese nombre(s)',
                        labelText: 'Nombre(s)',
                      ),
                      validator: (value) {
                        return RegexUtil.nombres.hasMatch(value ?? '')
                            ? null
                            : 'Los datos ingresados no son validos.';
                      },
                      //onChanged: (value) => accesoFormulario.correo = value,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: cApellido1,
                      style: const TextStyle(
                          color: AppTema.bluegrey700,
                          fontWeight: FontWeight.bold),
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecorations.registroLiderDecoration(
                        hintText: 'Ingrese primer apellido ',
                        labelText: 'Primer apellido',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: cApellido2,
                      style: const TextStyle(
                          color: AppTema.bluegrey700,
                          fontWeight: FontWeight.bold),
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecorations.registroLiderDecoration(
                        hintText: 'Ingrese segundo apellido',
                        labelText: 'Segundo apellido',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: cCorreo,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(
                          color: AppTema.bluegrey700,
                          fontWeight: FontWeight.bold),
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecorations.registroLiderDecoration(
                        hintText: 'Ingrese correo institucional',
                        labelText: 'Correo institucional',
                      ),
                      validator: (value) {
                        return RegexUtil.correoEdu.hasMatch(value ?? '')
                            ? null
                            : 'Correo electrónico invalido.';
                      },
                    ),
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      hint: const Text(
                        'Seleccione genero',
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
                        // setState(() {
                        //  // selectedState = newValue;
                        // });
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
                    Consumer(
                      builder: (context, ref, _) {
                        final fechas = ref.watch(fechaSeleccionadaRUASProv);
                        return ElevatedButton(
                          child: Text(
                            fechaSeleccionada != null
                                ? 'Fecha seleccionada: ${DateFormat('yyyy-MM-dd').format(fecha)}'
                                : 'Seleccione fecha de nacimiento',
                          ),
                          onPressed: fechaSeleccionada != null
                              ? null
                              : () => _mostrarDatePicker(context, ref),
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                    TextFormField(
                      maxLength: 18,
                      controller: cCurp,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                          color: AppTema.bluegrey700,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecorations.registroLiderDecoration(
                        hintText: 'Ingrese CURP',
                        labelText: 'CURP',
                      ),
                      validator: (value) {
                        int curpLength = value?.length ?? 0;
                        if (RegexUtil.curp.hasMatch(value ?? '')) {
                          // Genera la CURP para compararla
                          String curpGenerada = CurpGenerator.generateCurp(
                              cNombres.text,
                              cApellido1.text,
                              cApellido2.text,
                              fecha,
                              genero,
                              eNacimiento);

                          // Compara la CURP ingresada con la generada
                          if (curpLength == 18) {
                            if (curpGenerada.substring(0, 16) ==
                                cCurp.text.substring(0, 16)) {
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
                      //onChanged: (value) => accesoFormulario.correo = value,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      maxLength: 13,
                      controller: cRfc,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                          color: AppTema.bluegrey700,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecorations.registroLiderDecoration(
                        hintText: 'Ingrese RFC',
                        labelText: 'RFC',
                      ),
                      validator: (value) {
                        int curpLength = value?.length ?? 0;
                        if (RegexUtil.rfc.hasMatch(value ?? '')) {
                          // Genera la CURP para compararla
                          String curpGenerada = CurpGenerator.generateCurp(
                              cNombres.text,
                              cApellido1.text,
                              cApellido2.text,
                              fecha,
                              genero,
                              eNacimiento);

                          // Compara la CURP ingresada con la generada
                          if (curpLength == 13) {
                            if (curpGenerada.substring(0, 10) ==
                                cCurp.text.substring(0, 10)) {
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
                      controller: cNumIne,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      autocorrect: false,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          color: AppTema.bluegrey700,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecorations.registroLiderDecoration(
                        hintText: 'Ingrese No. Credencial INE',
                        labelText: 'No. Credencial INE ',
                      ),
                      validator: (value) {
                        return RegexUtil.ine.hasMatch(value ?? '')
                            ? null
                            : 'El numero de INE no es valido.';
                      },
                      //onChanged: (value) => accesoFormulario.correo = value,
                    ),
//                      SizedBox(height: 20),
                    const SizedBox(height: 20),
                    TextFormField(
                      maxLength: 10,
                      controller: cTelefono,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      autocorrect: false,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          color: AppTema.bluegrey700,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecorations.registroLiderDecoration(
                        hintText: 'Ingrese numero telefónico',
                        labelText: 'Numero telefónico',
                      ),
                      validator: (value) {
                        return RegexUtil.telefono.hasMatch(value ?? '')
                            ? null
                            : 'El numero telefónico no es valido.';
                      },
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Tipo de asesor',
                        style: TextStyle(
                            color: AppTema.bluegrey700,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField(
                        isExpanded: true,
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
                            value: 'Interno',
                            child: Text('Interno'),
                          ),
                          DropdownMenuItem(
                            value: 'Externo',
                            child: Text('Externo'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value == 'Interno') {
                            tipoAsesor = 'CARASE01';
                          } else {
                            tipoAsesor = 'CARASE02';
                          }
                        }),
                    const SizedBox(height: 20),
                    Container(
                      // padding: EdgeInsets.only(right: 2.0),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Nivel académico',
                        style: TextStyle(
                            color: AppTema.bluegrey700,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField(
                        isExpanded: true,
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
                            value: 'Maestria',
                            child: Text('Maestria'),
                          ),
                          DropdownMenuItem(
                            value: 'Doctorado',
                            child: Text('Doctorado'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            if (value == "Licenciatura") {
                              licen = true;
                              maes = false;
                              doc = false;
                            }
                            if (value == "Maestria") {
                              licen = true;
                              maes = true;
                              doc = false;
                            }
                            if (value == "Doctorado") {
                              licen = true;
                              maes = true;
                              doc = true;
                            }
                          });
                        }),
                    const SizedBox(height: 20),
                    if (licen == true) _Licenciatura(),
                    const SizedBox(height: 20),
                    if (maes == true) _Maestria(),
                    const SizedBox(height: 20),
                    if (doc == true) _Doctorado(),
                    Container(
                      height: 50,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: ElevatedButton(
                        child: const Center(
                            child: Text(
                          'Registrar',
                          style:
                              TextStyle(color: AppTema.grey100, fontSize: 25),
                        )),
                        onPressed: () {
                          // setState(() {
                          //   camposLlenos = _formKey.currentState!.validate();
                          //   print(camposLlenos);
                          // });
                          // if (camposLlenos) {
                          //   idPersona = Generar.idPersona(
                          //       cNombres.text.toUpperCase(),
                          //       cApellido1.text.toUpperCase(),
                          //       cApellido2.text.toUpperCase(),
                          //       cCorreo.text.toUpperCase());
                          //   contrasena = Generar.contrasenaAleatoria();
                          //   contrasenaHash = Generar.hashContrasena(contrasena);
                          //   existente();
                          //   // print(contrasena);
                          // } else {
                          //   QuickAlert.show(
                          //     context: context,
                          //     type: QuickAlertType.warning,
                          //     title: 'Cuidado',
                          //     text: 'Rellena los campos faltantes',
                          //     confirmBtnText: 'Hecho',
                          //     confirmBtnColor: AppTema.pizazz,
                          //   );
                          // }

                          print(genero);
                          print(eNacimiento);
                          //CurpGenerator.generateCurp(cNombres.text,cApellido1.text,cApellido2.text,fecha,);
                          print(
                            DateFormat('yyyy-MM-dd').format(fecha),
                          );
                          print(CurpGenerator.generateCurp(
                              'Juliana Margarita',
                              'Lopez',
                              'Gines',
                              DateTime(1997, 05, 16),
                              'M',
                              'Oaxaca'));
                        },
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    ));
  }

  Column _departamentoAdscrito(List<Departamento> dep) {
    return Column(
      children: [
        DropdownButtonFormField(
          //value: 'Licenciatura',
          hint: const Text(
            'Seleccione departamento adscrito',
            overflow: TextOverflow.visible,
            style: TextStyle(
                color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          isExpanded: true,
          style: const TextStyle(
              color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
          onChanged: (value) {
            valueDepartamento = value!.idDepartamento;
          },
          items: dep.map((itemone) {
            return DropdownMenuItem(
              alignment: Alignment.centerLeft,
              value: itemone,
              child: Text(
                itemone.nombreDepartamento,
                overflow: TextOverflow.visible,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Column _institutoPertenencia(List<Tecnologico> tecsD) {
    return Column(
      children: [
        DropdownButtonFormField(
          hint: const Text(
            'Seleccione instituto de pertenecía',
            overflow: TextOverflow.visible,
            style: TextStyle(
                color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          isExpanded: true,
          //value: 'Licenciatura',
          style: const TextStyle(
              color: AppTema.bluegrey700, fontWeight: FontWeight.bold),

          items: tecsD.map((itemone) {
            return DropdownMenuItem(
              alignment: Alignment.centerLeft,
              value: itemone,
              child: Text(
                itemone.nombreTecnologico,
                overflow: TextOverflow.visible,
              ),
            );
          }).toList(),
          onChanged: (value) {
            valueClaveTec = value!.claveTecnologico;
            setState(() {
              cargando3 = false;
            });
            obtenerDepartamento();
          },
        ),
      ],
    );
  }

  Column _tipoTecnologico(List<TipoTecnologico> tipo) {
    return Column(
      children: [
        DropdownButtonFormField(
          hint: const Text(
            'Seleccione tipo de instituto o centro de investigación',
            overflow: TextOverflow.visible,
            style: TextStyle(
                color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          isExpanded: true,
          style: const TextStyle(
              color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
          items: tipo.map((itemone) {
            return DropdownMenuItem(
              alignment: Alignment.centerLeft,
              value: itemone,
              child: Text(
                itemone.tipoTec,
                overflow: TextOverflow.visible,
              ),
            );
          }).toList(),
          onChanged: (value) {
            valueTipo = value!.idTipoTec;
            setState(() {
              cargando2 = false;
              cargando3 = false;
            });
            obtenerTecnologico();
          },
        ),
      ],
    );
  }
}
