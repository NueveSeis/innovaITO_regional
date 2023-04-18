import 'package:flutter/material.dart';
import 'package:innova_ito/theme/cambiar_tema.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegistroUsuarioLiderScreen extends StatelessWidget {
  const RegistroUsuarioLiderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final temaApp = Provider.of<CambiarTema>(context);
    return Scaffold(
        body: Fondo(
            tituloPantalla: 'Registro lider de proyecto',
            fontSize: 20,
            widget: Column(
              children: [
                SizedBox(height: 50),
                Text(
                  'Ingrese datos del estudiante',
                  style: TextStyle(
                      color: (temaApp.temaOscuro)
                          ? Colors.white
                          : CambiarTema.balticSea,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SingleChildScrollView(
                  child: Form(
                      child: Column(
                    children: [
                      TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecorations.registroLiderDecoration(
                            hintText: 'Correo electronico',
                            labelText: 'Correo electronico',
                            prefixIcon: Icons.person),
                        //onChanged: (value) => accesoFormulario.correo = value,
                      ),
                      TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecorations.registroLiderDecoration(
                            hintText: 'Correo electronico',
                            labelText: 'Correo electronico',
                            prefixIcon: Icons.person),
                        //onChanged: (value) => accesoFormulario.correo = value,
                      ),
                      TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecorations.registroLiderDecoration(
                            hintText: 'Correo electronico',
                            labelText: 'Correo electronico',
                            prefixIcon: Icons.person),
                        //onChanged: (value) => accesoFormulario.correo = value,
                      ),
                      TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecorations.registroLiderDecoration(
                            hintText: 'Correo electronico',
                            labelText: 'Correo electronico',
                            prefixIcon: Icons.person),
                        //onChanged: (value) => accesoFormulario.correo = value,
                      ),
                      TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecorations.registroLiderDecoration(
                            hintText: 'Correo electronico',
                            labelText: 'Correo electronico',
                            prefixIcon: Icons.person),
                        //onChanged: (value) => accesoFormulario.correo = value,
                      ),
                      TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecorations.registroLiderDecoration(
                            hintText: 'Correo electronico',
                            labelText: 'Correo electronico',
                            prefixIcon: Icons.person),
                        //onChanged: (value) => accesoFormulario.correo = value,
                      ),
                    ],
                  )),
                ),
              ],
            )));
  }
}
