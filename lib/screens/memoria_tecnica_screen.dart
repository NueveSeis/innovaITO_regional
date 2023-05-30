import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/services.dart';
//import 'package:flutter_quill/flutter_quill.dart';

class MemoriaTecnicaScreen extends StatelessWidget {
  static const String name = 'memoria_tecnica';
  MemoriaTecnicaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Fondo(
        tituloPantalla: 'Memoria tecnica',
        fontSize: 25,
        widget: Column(children: [
          const SizedBox(height: 50),
          const Text(
            'Datos la memoria técnica',
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
                TextFormField(
                  maxLength: 300,
                  maxLines: null,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText:
                        'Ingrese la descripción de la problemática y justificación.',
                    labelText: 'Problemática y justificación',
                  ),
                  //onChanged: (value) => accesoFormulario.correo = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  maxLength: 220,
                  maxLines: null,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText:
                        'Ingrese el estado de la técnica (estado del arte).',
                    labelText: 'Estado de la técnica (estado del arte)',
                  ),
                  //onChanged: (value) => accesoFormulario.correo = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  //initialValue: 'Hola perros',
                  // minLines: 3,
                  maxLength: 220,
                  maxLines: null,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Ingrese la descripción de la innovación.',
                    labelText: 'Descripción de la innovación',
                  ),
                  //onChanged: (value) => accesoFormulario.correo = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  maxLength: 220,
                  maxLines: null,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText:
                        'Ingrese propuesta de valor e impacto en el sector estratégico.',
                    labelText:
                        'Propuesta de valor e impacto en el sector estratégico',
                    //prefixIcon: Icons.person
                  ),
                  //onChanged: (value) => accesoFormulario.correo = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  maxLength: 300,
                  maxLines: null,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Ingrese mercado potencial objetivo.',
                    labelText: 'Mercado potencial objetivo',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                    maxLength: 300,
                    maxLines: null,
                    style: const TextStyle(
                        color: AppTema.bluegrey700,
                        fontWeight: FontWeight.bold),
                    autocorrect: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecorations.registroLiderDecoration(
                      hintText: 'Ingrese viabilidad técnica.',
                      labelText: 'Viabilidad técnica',
                    )),
                const SizedBox(height: 20),
                TextFormField(
                  maxLength: 220,
                  maxLines: null,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Ingrese viabilidad financiera.',
                    labelText: 'Viabilidad financiera',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  maxLength: 110,
                  maxLines: null,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Ingrese estrategia de propiedad intelectual.',
                    labelText: 'Estrategia de propiedad intelectual',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  maxLength: 300,
                  maxLines: null,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Ingrese interpretación de resultados.',
                    labelText: 'Interpretación de resultados',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  maxLength: 110,
                  maxLines: null,
                  style: const TextStyle(
                      color: AppTema.bluegrey700, fontWeight: FontWeight.bold),
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.registroLiderDecoration(
                    hintText: 'Ingrese Fuentes consultadas.',
                    labelText: 'Fuentes consultadas',
                  ),
                ),
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
                    onPressed: () {},
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
