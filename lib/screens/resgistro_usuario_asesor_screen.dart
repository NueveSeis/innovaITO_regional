import 'package:flutter/material.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:innova_ito/models/models.dart';

class RegistroUsuarioAsesorScreen extends StatelessWidget {
  const RegistroUsuarioAsesorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> tipoInst = ModeloTecnologicos().institutos;
    List<String> centros = ModeloTecnologicos().centros;
    List<String> tecsF = ModeloTecnologicos().tecnologicosF;
    List<String> tecsD = ModeloTecnologicos().tecnologicosD;
    List<String> carreras = ModeloTecnologicos().carrera;

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
                  items: tecsF.map((itemone) {
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
//                      SizedBox(height: 20),
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
                      Navigator.pushNamed(context, 'registro_usuario_lider');
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
