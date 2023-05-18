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
    obtenerTipoTec();
    //obtenerTecnologico();
  }

  final jobRoleCtrl = TextEditingController();
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

  Future agregarPersona() async {
    var url = 'https://evarafael.com/Aplicacion/rest/agregarAsesor.php';
    await http.post(Uri.parse(url), body: {
      'Id_persona': 'kdjjdkk9',
      'Nombre_persona': 'sexso99',
      'Apellido1': 'kolll',
      'Apellido2': 'man',
      'Telefono': '9512751745',
      'Correo_electronico': 'sima@gmail.com',
      'Num_ine': '12345678909876',
      'Curp': 'hgdgg738b',
      'Id_usuario ': 'user145',
      'Nombre_usuario': 'sima@gmail.com',
      'Contrasena': 'hola23',
      'Id_rol': 'ROL03',
      'Id_asesor': 'aser190',
      'RFC': 'RFC97678',
      'Abreviatura_profesional': 'M.T.E',
      'Licenciatura': 'sistemas',
      'Maestria': 'datos',
      'Doctorado': 'null',
      'Id_departamento': 'DEP03',
      'Id_cargoAsesor': 'CARASE02',
    });
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
    //print(tecnologicoM[0].nombreTecnologico);
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
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
                  keyboardType: TextInputType.number,
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
                    onChanged: (value) {}),
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
                      });
                    }),
                const SizedBox(height: 20),
                if (licen == true) ..._Licenciatura(),
                if (maes == true) ..._Maestria(),
                if (doc == true) ..._Doctorado(),
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
                    onPressed: () async {
                      agregarPersona();
                      await QuickAlert.show(
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

  Column _departamentoAdscrito(List<Departamento> dep) {
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
