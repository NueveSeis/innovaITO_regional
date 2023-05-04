import 'package:flutter/material.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:mailer/mailer.dart';

import 'package:innova_ito/theme/cambiar_tema.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:mailer/smtp_server.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

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
                const SizedBox(height: 50),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Form(
                      child: Column(
                    children: [
                      const SizedBox(height: 20),
                      DropdownButtonFormField(
                          value: 'Licenciatura',
                          style: const TextStyle(
                              color: CambiarTema.bluegrey700,
                              fontWeight: FontWeight.bold),
                          items: const [
                            DropdownMenuItem(
                              value: 'Licenciatura',
                              child: Text('Licenciatura'),
                            ),
                            DropdownMenuItem(
                              value: 'Postgrado',
                              child: Text('Postgrado'),
                            ),
                          ],
                          onChanged: (value) {
                            print(value);
                          }),
                      const SizedBox(height: 20),
                      TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                            color: CambiarTema.bluegrey700,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecorations.registroLiderDecoration(
                          hintText: 'Ingrese matricula',
                          labelText: 'Matricula',

                          //prefixIcon: Icons.person
                        ),
                        //onChanged: (value) => accesoFormulario.correo = value,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        style: const TextStyle(
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
                      const SizedBox(height: 20),
                      TextFormField(
                        style: const TextStyle(
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
                      const SizedBox(height: 20),
                      TextFormField(
                        style: const TextStyle(
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
                      const SizedBox(height: 20),
                      TextFormField(
                        style: const TextStyle(
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
//                      SizedBox(height: 20),
                      Container(
                        height: 50,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: ElevatedButton(
                          child: const Center(
                              //height: 50,
                              child: Text(
                            'Registrar',
                            style: TextStyle(
                                color: CambiarTema.grey100, fontSize: 25),
                          )),
                          onPressed: () {
                            //Navigator.pushNamed(context, 'registro_usuario_lider');
                            sendEmail();
                            siAlerta(context);
                          },
                        ),
                      ),
                    ],
                  )),
                ),
              ],
            )));
  }

  void siAlerta(BuildContext context) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Agregado correctamente',
      autoCloseDuration: Duration(seconds: 7),
      confirmBtnText: 'Hecho',
      confirmBtnColor: AppTema.pizazz,
    );
  }

  Future sendEmail() async{
    final email = 'nueveseisss@gmail.com';
    final pass = 'wwhxyufesxbankzc';
    final st = '<!DOCTYPE html> <html> <head> <title>Bienvenido(a) a InnovaITO</title> <meta charset="UTF-8"> <meta name="viewport" content="width=device-width, initial-scale=1.0"> <style type="text/css"> body { font-family: ''Segoe UI'', Tahoma, Geneva, Verdana, sans-serif; background-color: #F9B74E; background-image: linear-gradient(315deg, #F9B74E 0%, #FF9500 74%); } .container { max-width: 600px; margin: 0 auto; padding: 20px; background-color: #FFF; border-radius: 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.3); } .header { text-align: center; margin-bottom: 30px; } .header img { width: 150px; height: 150px; margin-bottom: 20px; } .header h1 { font-size: 36px; color: #FA7A1E; margin-bottom: 5px; } .header p { font-size: 18px; color: #333; margin-bottom: 0; } .info { font-size: 18px; color: #333; margin-bottom: 20px; } .info p { margin-bottom: 10px; } .cta { text-align: center; } .cta a { display: inline-block; background-color: #FA7A1E; color: #FFF; text-decoration: none; font-size: 18px; padding: 10px 20px; border-radius: 5px; transition: all 0.2s ease-in-out; } .cta a:hover { background-color: #F9B74E; color: #FFF; } .footer { text-align: center; margin-top: 50px; font-size: 14px; color: #333; } </style> </head> <body> <div class="container"> <div class="header"> <img src="https://evarafael.com/Aplicacion/logo_innovaITO_negro.png" alt="InnovaITO"> <h1>Bienvenido(a) a InnovaITO</h1> <p>¡Gracias por crear tu cuenta!</p> </div> <div class="info"> <p>Tu cuenta ha sido creada con éxito. A continuación, te proporcionamos la información de inicio de sesión:</p> <p><strong>Correo electrónico:</strong> correo@innovaito.com</p> <p><strong>Contraseña:</strong> *********</p> <p>Te recomendamos cambiar tu contraseña al iniciar sesión por primera vez para asegurarte de que tu cuenta esté protegida.</p> </div> <div class="cta"> <a href="#">Iniciar sesión</a> </div> <div class="footer"> <p>Este mensaje se envió automáticamente. Por favor, no respondas a este correo electrónico.</p> ';
    final smtpServer = gmail(email, pass);
    final message = Message()
     ..from = Address(email,'Kevin')
     ..recipients = ['L17161164@oaxaca.tecnm.mx']
     ..subject = 'Registro de lider de proyecto ${DateTime.now()}'
     ..html=st;

     try{
      await send(message,smtpServer);
      print('email enviado');
      //siAlerta(context);
     }on MailerException catch (e) {
      print(e);
      print('no enviado');
     }
     



  }
}
