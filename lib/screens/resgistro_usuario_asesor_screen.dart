import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
//import 'package:animated_custom_dropdown/custom_dropdown.dart';

import 'package:innova_ito/helpers/helpers.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:innova_ito/models/models.dart';

class RegistroUsuarioAsesorScreen extends StatefulWidget {
  const RegistroUsuarioAsesorScreen({super.key});

  @override
  State<RegistroUsuarioAsesorScreen> createState() =>
      _RegistroUsuarioAsesorScreenState();
}

class _RegistroUsuarioAsesorScreenState
    extends State<RegistroUsuarioAsesorScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerTecnologico();
  }

  TextEditingController _tipoTecController = TextEditingController();
  final jobRoleCtrl = TextEditingController();
  bool licen = false;
  bool maes = false;
  bool doc = false;
  List<Tecnologico> tecnologicoM = [];
  List<TipoTecnologico> tipoTec = [];

  Future obtenerTecnologico() async {
    var url = 'https://evarafael.com/Aplicacion/rest/get_tecnologico.php';
    var response = await http.get(Uri.parse(url));
    tecnologicoM = tecnologicoFromJson(response.body);
    print(tecnologicoM[0].nombreTecnologico);
  }

  Future obtenerTipoTec() async {
    var url = 'https://evarafael.com/Aplicacion/rest/get_tipoTec.php';
    var response = await http.get(Uri.parse(url));
    tipoTec = tipoTecnologicoFromJson(response.body);
    print(tipoTec[0].tipoTec);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _Licenciatura() {
      return [
        const SizedBox(height: 20),
        TextFormField(
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
          //onChanged: (value) => accesoFormulario.correo = value,
        ),
      ];
    }

    List<Widget> _Maestria() {
      return [
        const SizedBox(height: 20),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
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
          //onChanged: (value) => accesoFormulario.correo = value,
        ),
        const SizedBox(height: 20),
        TextFormField(
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
        ),
      ];
    }

    List<Widget> _Doctorado() {
      return [
        const SizedBox(height: 20),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
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
          //onChanged: (value) => accesoFormulario.correo = value,
        ),
        const SizedBox(height: 20),
        TextFormField(
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
        ),
        const SizedBox(height: 20),
        TextFormField(
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
          //onChanged: (value) => accesoFormulario.correo = value,
        ),
      ];
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
                child: Column(
              children: [
                const SizedBox(height: 20),
                FutureBuilder(
                  future: obtenerTipoTec(),
                  builder: (BuildContext context, AsyncSnapshot snapshop) {
                    if (snapshop.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      return _tipoTecnologico(tipoTec);
                    }
                  },
                ),
                const SizedBox(height: 20),
                //_institutoPertenencia(tecsD),
                const SizedBox(height: 20),
                // _departamentoAdscrito(carreras),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Titulo',
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
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
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Ingrese apellido paterno',
                    labelText: 'Apellido paterno',
                  ),

                  //onChanged: (value) => accesoFormulario.correo = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Ingrese apellido materno',
                    labelText: 'Apellido materno',
                    //prefixIcon: Icons.person
                  ),

                  //onChanged: (value) => accesoFormulario.correo = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Ingrese correo institucional',
                    labelText: 'Correo institucional',
                    //prefixIcon: Icons.person
                  ),
                  validator: (value) {
                    return RegexUtil.correoEdu.hasMatch(value ?? '')
                        ? null
                        : 'Correo electronico invalido.';
                  },
                  //onChanged: (value) => accesoFormulario.correo = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Ingrese CURP',
                    labelText: 'CURP',
                  ),
                  validator: (value) {
                    return RegexUtil.curp.hasMatch(value ?? '')
                        ? null
                        : 'La CURP ingresada no es valida.';
                  },
                  //onChanged: (value) => accesoFormulario.correo = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Ingrese RFC',
                    labelText: 'RFC',
                  ),
                  validator: (value) {
                    return RegexUtil.rfc.hasMatch(value ?? '')
                        ? null
                        : 'El RFC no es valido.';
                  },
                  //onChanged: (value) => accesoFormulario.correo = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autocorrect: false,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Ingrese numero telefonico',
                    labelText: 'Numero telefonico',
                  ),
                  validator: (value) {
                    return RegexUtil.telefono.hasMatch(value ?? '')
                        ? null
                        : 'El numero telefonico no es valido.';
                  },
                  //onChanged: (value) => accesoFormulario.correo = value,
                ),
                const SizedBox(height: 20),
                Container(
                  // padding: EdgeInsets.only(right: 2.0),
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
                      setState(() {});
                    }),
                const SizedBox(height: 20),
                Container(
                  // padding: EdgeInsets.only(right: 2.0),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Nivel academico',
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
                          licen = false;
                          maes = true;
                          doc = false;
                        }
                        if (value == "Doctorado") {
                          licen = false;
                          maes = false;
                          doc = true;
                        }
                        ;
                      });
                    }),

                if (licen == true) ..._Licenciatura(),
                if (maes == true) ..._Maestria(),
                if (doc == true) ..._Doctorado(),

                const SizedBox(height: 20),

                Container(
                  height: 50,
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: ElevatedButton(
                    child: const Center(
                        child: Text(
                      'Registrar',
                      style: TextStyle(color: AppTema.grey100, fontSize: 25),
                    )),
                    onPressed: () {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        title: 'Carrera agregada',
                        confirmBtnText: 'Hecho',
                        confirmBtnColor: AppTema.pizazz,
                      );
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

  Column _departamentoAdscrito(List<String> carreras) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: const Text(
            'Departamento adscrito',
            style: TextStyle(
                color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField(
          //value: 'Licenciatura',
          isExpanded: true,
          style: const TextStyle(
              color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
          onChanged: (value) {
            print(value);
          },
          items: carreras.map((itemone) {
            return DropdownMenuItem(
              alignment: Alignment.centerLeft,
              value: itemone,
              child: Text(
                itemone,
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
        Container(
          // padding: EdgeInsets.only(right: 2.0),
          alignment: Alignment.topLeft,
          child: const Text(
            'Instituto de pertenecia',
            style: TextStyle(
                color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField(
          isExpanded: true,
          //value: 'Licenciatura',
          style: const TextStyle(
              color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
          onChanged: (value) {
            print(value.toString());
          },
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
        ),
      ],
    );
  }

  Column _tipoTecnologico(List<TipoTecnologico> tipo) {
    return Column(
      children: [
        Container(
          // padding: EdgeInsets.only(right: 2.0),
          alignment: Alignment.topLeft,
          child: const Text(
            'Tipo de instituto o centro de investigación',
            style: TextStyle(
                color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField(
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
            TipoTecnologico? simon = value;
            print(simon.toString());
          },
        ),
      ],
    );
  }
}
