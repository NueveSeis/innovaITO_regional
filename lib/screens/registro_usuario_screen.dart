import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/theme/cambiar_tema.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegistroUsuarioScreen extends StatelessWidget {
  static const String name = 'registro_usuario';
  const RegistroUsuarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final temaApp = Provider.of<CambiarTema>(context);
    return Scaffold(
        body: Fondo(
            tituloPantalla: 'Registro de usuarios',
            fontSize: 20,
            widget: Column(children: [
              SizedBox(height: 50),
              Text(
                'Selecciona tipo de usuario',
                style: TextStyle(
                    color: (temaApp.temaOscuro)
                        ? Colors.white
                        : CambiarTema.balticSea,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SingleChildScrollView(
                //padding: EdgeInsets.only(top: 25, bottom: 25),
                //width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: MaterialButton(
                          splashColor: CambiarTema.pizazz,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 200,
                          elevation: 15.0,
                          color: (temaApp.temaOscuro)
                              ? CambiarTema.emperor
                              : CambiarTema.grey100,
                          child: Container(
                              child: Text(
                            'Lider de proyecto',
                            style: TextStyle(
                                color: (temaApp.temaOscuro)
                                    ? CambiarTema.indigo50
                                    : CambiarTema.bluegrey700,
                                fontSize: 25),
                          )),
                          onPressed: () {
                            context.pushNamed('registro_usuario_lider');
                            // Navigator.pushNamed(
                            //   context, 'registro_usuario_lider');
                          }),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: MaterialButton(
                          splashColor: CambiarTema.pizazz,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 200,
                          elevation: 15.0,
                          color: (temaApp.temaOscuro)
                              ? CambiarTema.emperor
                              : CambiarTema.grey100,
                          child: Container(
                              child: Text(
                            'Asesor',
                            style: TextStyle(
                                color: (temaApp.temaOscuro)
                                    ? CambiarTema.indigo50
                                    : CambiarTema.bluegrey700,
                                fontSize: 25),
                          )),
                          onPressed: () {
                            context.pushNamed('registro_usuario_asesor');
                            // Navigator.pushNamed(
                            //   context, 'registro_usuario_asesor');
                          }),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
