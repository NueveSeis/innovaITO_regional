import 'package:flutter/material.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:innova_ito/models/models.dart';

import 'package:quickalert/quickalert.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:drop_down_list/drop_down_list.dart';

import 'package:animated_custom_dropdown/custom_dropdown.dart';

class RegistroUsuarioAsesorScreen extends StatefulWidget {
  const RegistroUsuarioAsesorScreen({super.key});

  @override
  State<RegistroUsuarioAsesorScreen> createState() =>
      _RegistroUsuarioAsesorScreenState();
}

class _RegistroUsuarioAsesorScreenState
    extends State<RegistroUsuarioAsesorScreen> {
  final jobRoleCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> tipoInst = ModeloTecnologicos().institutos;
    List<String> centros = ModeloTecnologicos().centros;
    List<String> tecsF = ModeloTecnologicos().tecnologicosF;
    List<String> tecsD = ModeloTecnologicos().tecnologicosD;
    List<String> carreras = ModeloTecnologicos().carrera;
    String simon = '';

    List<Widget> _Licenciatura() {
      return [
        const SizedBox(height: 20),
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
              color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
          decoration: InputDecorations.registroLiderDecoration(
            hintText: 'Ingrese licenciatura',
            labelText: 'Licenciatura',
          ),
          //onChanged: (value) => accesoFormulario.correo = value,
        ),
      ];
    }

    List<Widget> _Maestria() {
      return [
        const SizedBox(height: 20),
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
              color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
          decoration: InputDecorations.registroLiderDecoration(
            hintText: 'Ingrese licenciatura',
            labelText: 'Licenciatura',
          ),
          //onChanged: (value) => accesoFormulario.correo = value,
        ),
        const SizedBox(height: 20),
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
              color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
          decoration: InputDecorations.registroLiderDecoration(
            hintText: 'Ingrese Maestria',
            labelText: 'Maestria',
          ),
          //onChanged: (value) => accesoFormulario.correo = value,
        ),
      ];
    }

    List<Widget> _Doctorado() {
      return [
        const SizedBox(height: 20),
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
              color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
          decoration: InputDecorations.registroLiderDecoration(
            hintText: 'Ingrese licenciatura',
            labelText: 'Licenciatura',
          ),
          //onChanged: (value) => accesoFormulario.correo = value,
        ),
        const SizedBox(height: 20),
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
              color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
          decoration: InputDecorations.registroLiderDecoration(
            hintText: 'Ingrese Maestria',
            labelText: 'Maestria',
          ),
          //onChanged: (value) => accesoFormulario.correo = value,
        ),
        const SizedBox(height: 20),
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
              color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
          decoration: InputDecorations.registroLiderDecoration(
            hintText: 'Ingrese Doctorado',
            labelText: 'Doctorado',
          ),
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
                Container(
                  // padding: EdgeInsets.only(right: 2.0),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Tipo de instituto o centro de investigación',
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
                  //value: 'Licenciatura',
                  isExpanded: true,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  onChanged: (value) {
                    print(value);
                  },
                  items: tipoInst.map((itemone) {
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
                const SizedBox(height: 20),

                Container(
                  // padding: EdgeInsets.only(right: 2.0),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Instituto de pertenecia',
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
                  //value: 'Licenciatura',
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  onChanged: (value) {
                    print(value);
                  },
                  items: tecsD.map((itemone) {
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
                const SizedBox(height: 20),
                CustomDropdown.search(
                  hintText: 'Select job role',
                  items: const [
                    'Developer',
                    'Instituto Tecnológico de Estudios Superiores de La Región Carbonífera',
                    'Consultant',
                    'Student'
                  ],
                  controller: jobRoleCtrl,
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Departamento adscrito',
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
                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Titulo',
                    labelText: 'Titulo (Lic., M.C., Dr.)',
                  ),
                  //onChanged: (value) => accesoFormulario.correo = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Ingrese nombre(s)',
                    labelText: 'Nombre(s)',
                  ),
                  //onChanged: (value) => accesoFormulario.correo = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Ingrese apellido paterno',
                    labelText: 'Apellido paterno',
                  ),
                  //onChanged: (value) => accesoFormulario.correo = value,
                ),
                const SizedBox(height: 20),

                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Ingrese apellido materno',
                    labelText: 'Apellido materno',
                    //prefixIcon: Icons.person
                  ),
                  //onChanged: (value) => accesoFormulario.correo = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Ingrese correo electronico',
                    labelText: 'Correo electronico',
                    //prefixIcon: Icons.person
                  ),
                  //onChanged: (value) => accesoFormulario.correo = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Ingrese CURP',
                    labelText: 'CURP',
                  ),
                  //onChanged: (value) => accesoFormulario.correo = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Ingrese RFC',
                    labelText: 'RFC',
                  ),
                  //onChanged: (value) => accesoFormulario.correo = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Ingrese No. Credencial INE',
                    labelText: 'No. Credencial INE ',
                  ),
                  //onChanged: (value) => accesoFormulario.correo = value,
                ),
//                      SizedBox(height: 20),
                const SizedBox(height: 20),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Ingrese numero telefonico',
                    labelText: 'Numero telefonico',
                  ),
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
                      setState(() {});
                    }),

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
                      // Navigator.pushNamed(context, 'registro_usuario_lider');
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
}
