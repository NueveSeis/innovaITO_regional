import 'package:flutter/material.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';
//import 'package:flutter_quill/flutter_quill.dart';

class FichaTecnicaScreen extends StatelessWidget {
  const FichaTecnicaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // QuillController _controller = QuillController.basic();
    List<String> categoria = ModeloTecnologicos().categorias;
    List<String> naturaleza = ModeloTecnologicos().naturalezaTecnica;
    return Scaffold(
      body: Fondo(
        tituloPantalla: 'Ficha tecnica',
        fontSize: 25,
        widget: Column(children: [
          const SizedBox(height: 50),
          const Text(
            'Datos del proyecto',
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
                    'Seleccione categoria:',
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
                  items: categoria.map((itemone) {
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
                    'Seleccione área de aplicación:',
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
                  items: categoria.map((itemone) {
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
                    'Seleccione naturaleza técnica:',
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
                  items: naturaleza.map((itemone) {
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
                    hintText: 'Ingrese nombre corto (nombre comercial)',
                    labelText: 'Nombre corto (nombre comercial)',
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
                    hintText: 'Ingrese nombre descriptivo:',
                    labelText: 'Nombre descriptivo',
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
//                 SizedBox(height: 20),

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
        ]),
      ),
    );
  }
}
