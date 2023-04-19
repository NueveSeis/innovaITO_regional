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
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Form(
                      child: Column(
                    children: [
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(
                            color: CambiarTema.bluegrey700,
                            fontWeight: FontWeight.bold),
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecorations.registroLiderDecoration(
                          hintText: 'Ingrese matricula',
                          labelText: 'Matricula',
                          //prefixIcon: Icons.person
                        ),
                        //onChanged: (value) => accesoFormulario.correo = value,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(
                            color: CambiarTema.bluegrey700,
                            fontWeight: FontWeight.bold),
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecorations.registroLiderDecoration(
                          hintText: 'Ingrese nombre(s)',
                          labelText: 'Nombre(s)',
                          //prefixIcon: Icons.person
                        ),
                        //onChanged: (value) => accesoFormulario.correo = value,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(
                            color: CambiarTema.bluegrey700,
                            fontWeight: FontWeight.bold),
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecorations.registroLiderDecoration(
                          hintText: 'Ingrese apellido paterno',
                          labelText: 'Apellido paterno',
                          //prefixIcon: Icons.person
                        ),
                        //onChanged: (value) => accesoFormulario.correo = value,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(
                            color: CambiarTema.bluegrey700,
                            fontWeight: FontWeight.bold),
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecorations.registroLiderDecoration(
                          hintText: 'Ingrese apellido materno',
                          labelText: 'Apellido materno',
                          //prefixIcon: Icons.person
                        ),
                        //onChanged: (value) => accesoFormulario.correo = value,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(
                            color: CambiarTema.bluegrey700,
                            fontWeight: FontWeight.bold),
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecorations.registroLiderDecoration(
                          hintText: 'Ingrese correo electronico',
                          labelText: 'Correo electronico',
                          //prefixIcon: Icons.person
                        ),
                        //onChanged: (value) => accesoFormulario.correo = value,
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: MaterialButton(
                            splashColor: CambiarTema.grey100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 60,
                            elevation: 15.0,
                            color: CambiarTema.pizazz,
                            child: Container(
                                child: Text(
                              'Registrar',
                              style: TextStyle(
                                  color: CambiarTema.grey100, fontSize: 25),
                            )),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, 'registro_usuario_lider');
                            }),
                      ),
                    ],
                  )),
                ),
              ],
            )));
  }
}
