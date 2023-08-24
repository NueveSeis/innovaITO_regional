import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Correo {
  static Future<void> registroLider(
      BuildContext context,
      String correo,
      String contrasena,
      String nombre,
      String apellidoP,
      String apellidoM) async {
    const email = 'nueveseisss@gmail.com';
    const pass = 'wwhxyufesxbankzc';
    final st =
        '<!DOCTYPE html> <html> <head> <title>Bienvenido(a) a InnovaITO</title> <meta charset="UTF-8"> <meta name="viewport" content="width=device-width, initial-scale=1.0"> <style type="text/css"> body { font-family: '
        'Segoe UI'
        ', Tahoma, Geneva, Verdana, sans-serif; background-color: #F9B74E; background-image: linear-gradient(315deg, #F9B74E 0%, #FF9500 74%); } .container { max-width: 600px; margin: 0 auto; padding: 20px; background-color: #FFF; border-radius: 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.3); } .header { text-align: center; margin-bottom: 30px; } .header img { width: 150px; height: 150px; margin-bottom: 20px; } .header h1 { font-size: 36px; color: #FA7A1E; margin-bottom: 5px; } .header p { font-size: 18px; color: #333; margin-bottom: 0; } .info { font-size: 18px; color: #333; margin-bottom: 20px; } .info p { margin-bottom: 10px; } .cta { text-align: center; } .cta a { display: inline-block; background-color: #FA7A1E; color: #FFF; text-decoration: none; font-size: 18px; padding: 10px 20px; border-radius: 5px; transition: all 0.2s ease-in-out; } .cta a:hover { background-color: #F9B74E; color: #FFF; } .footer { text-align: center; margin-top: 50px; font-size: 14px; color: #333; } </style> </head> <body> <div class="container"> <div class="header"> <img src="https://evarafael.com/Aplicacion/logo_innovaITO_negro.png" alt="InnovaITO"> <h1>Bienvenido(a) a InnovaITO</h1> <p>${nombre} ${apellidoP} ${apellidoM} </p> </div> <div class="info"> <p>Tu cuenta ha sido creada con éxito. A continuación, te proporcionamos la información de inicio de sesión:</p> <p><strong>Correo electrónico:</strong> ${correo}</p> <p><strong>Contraseña:</strong> ${contrasena}</p> <p>Te recomendamos cambiar tu contraseña al iniciar sesión por primera vez para asegurarte de que tu cuenta esté protegida.</p> </div> <div class="cta"> <a href="#">Iniciar sesión</a> </div> <div class="footer"> <p>Este mensaje se envió automáticamente. Por favor, no respondas a este correo electrónico.</p> ';
    final smtpServer = gmail(email, pass);
    final message = Message()
      ..from = const Address(email, 'Kevin')
      ..recipients = [(correo)]
      ..subject = 'Registro de lider de proyecto ${DateTime.now()}'
      ..html = st;

    try {
      await send(message, smtpServer);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Agregado correctamente',
        confirmBtnText: 'Hecho',
        confirmBtnColor: AppTema.pizazz,
      );
      //siAlerta(context);
    } on MailerException catch (e) {
      print(e);
    }
  }

  static Future<void> registroAsesor(
      BuildContext context,
      String correo,
      String contrasena,
      String nombre,
      String apellidoP,
      String apellidoM) async {
    const email = 'nueveseisss@gmail.com';
    const pass = 'wwhxyufesxbankzc';
    final st =
        '<!DOCTYPE html> <html> <head> <title>Bienvenido(a) a InnovaITO</title> <meta charset="UTF-8"> <meta name="viewport" content="width=device-width, initial-scale=1.0"> <style type="text/css"> body { font-family: '
        'Segoe UI'
        ', Tahoma, Geneva, Verdana, sans-serif; background-color: #F9B74E; background-image: linear-gradient(315deg, #F9B74E 0%, #FF9500 74%); } .container { max-width: 600px; margin: 0 auto; padding: 20px; background-color: #FFF; border-radius: 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.3); } .header { text-align: center; margin-bottom: 30px; } .header img { width: 150px; height: 150px; margin-bottom: 20px; } .header h1 { font-size: 36px; color: #FA7A1E; margin-bottom: 5px; } .header p { font-size: 18px; color: #333; margin-bottom: 0; } .info { font-size: 18px; color: #333; margin-bottom: 20px; } .info p { margin-bottom: 10px; } .cta { text-align: center; } .cta a { display: inline-block; background-color: #FA7A1E; color: #FFF; text-decoration: none; font-size: 18px; padding: 10px 20px; border-radius: 5px; transition: all 0.2s ease-in-out; } .cta a:hover { background-color: #F9B74E; color: #FFF; } .footer { text-align: center; margin-top: 50px; font-size: 14px; color: #333; } </style> </head> <body> <div class="container"> <div class="header"> <img src="https://evarafael.com/Aplicacion/logo_innovaITO_negro.png" alt="InnovaITO"> <h1>Bienvenido(a) a InnovaITO</h1> <p>${nombre} ${apellidoP} ${apellidoM} </p> </div> <div class="info"> <p>Tu cuenta ha sido creada con éxito. A continuación, te proporcionamos la información de inicio de sesión:</p> <p><strong>Correo electrónico:</strong> ${correo}</p> <p><strong>Contraseña:</strong> ${contrasena}</p> <p>Te recomendamos cambiar tu contraseña al iniciar sesión por primera vez para asegurarte de que tu cuenta esté protegida.</p> </div> <div class="cta"> <a href="#">Iniciar sesión</a> </div> <div class="footer"> <p>Este mensaje se envió automáticamente. Por favor, no respondas a este correo electrónico.</p> ';
    final smtpServer = gmail(email, pass);
    final message = Message()
      ..from = const Address(email, 'Kevin')
      ..recipients = [(correo)]
      ..subject = 'Registro de asesor ${DateTime.now()}'
      ..html = st;

    try {
      await send(message, smtpServer);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Agregado correctamente',
        confirmBtnText: 'Hecho',
        confirmBtnColor: AppTema.pizazz,
      );
      //siAlerta(context);
    } on MailerException catch (e) {
      print(e);
    }
  }

  static Future<void> registroJurado(
      BuildContext context,
      String correo,
      String contrasena,
      String nombre,
      String apellidoP,
      String apellidoM) async {
    const email = 'nueveseisss@gmail.com';
    const pass = 'wwhxyufesxbankzc';
    final st =
        '<!DOCTYPE html> <html> <head> <title>Bienvenido(a) a InnovaITO</title> <meta charset="UTF-8"> <meta name="viewport" content="width=device-width, initial-scale=1.0"> <style type="text/css"> body { font-family: '
        'Segoe UI'
        ', Tahoma, Geneva, Verdana, sans-serif; background-color: #F9B74E; background-image: linear-gradient(315deg, #F9B74E 0%, #FF9500 74%); } .container { max-width: 600px; margin: 0 auto; padding: 20px; background-color: #FFF; border-radius: 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.3); } .header { text-align: center; margin-bottom: 30px; } .header img { width: 150px; height: 150px; margin-bottom: 20px; } .header h1 { font-size: 36px; color: #FA7A1E; margin-bottom: 5px; } .header p { font-size: 18px; color: #333; margin-bottom: 0; } .info { font-size: 18px; color: #333; margin-bottom: 20px; } .info p { margin-bottom: 10px; } .cta { text-align: center; } .cta a { display: inline-block; background-color: #FA7A1E; color: #FFF; text-decoration: none; font-size: 18px; padding: 10px 20px; border-radius: 5px; transition: all 0.2s ease-in-out; } .cta a:hover { background-color: #F9B74E; color: #FFF; } .footer { text-align: center; margin-top: 50px; font-size: 14px; color: #333; } </style> </head> <body> <div class="container"> <div class="header"> <img src="https://evarafael.com/Aplicacion/logo_innovaITO_negro.png" alt="InnovaITO"> <h1>Bienvenido(a) a InnovaITO</h1> <p>${nombre} ${apellidoP} ${apellidoM} </p> </div> <div class="info"> <p>Tu cuenta ha sido creada con éxito. A continuación, te proporcionamos la información de inicio de sesión:</p> <p><strong>Correo electrónico:</strong> ${correo}</p> <p><strong>Contraseña:</strong> ${contrasena}</p> <p>Te recomendamos cambiar tu contraseña al iniciar sesión por primera vez para asegurarte de que tu cuenta esté protegida.</p> </div> <div class="cta"> <a href="#">Iniciar sesión</a> </div> <div class="footer"> <p>Este mensaje se envió automáticamente. Por favor, no respondas a este correo electrónico.</p> ';
    final smtpServer = gmail(email, pass);
    final message = Message()
      ..from = const Address(email, 'Kevin')
      ..recipients = [(correo)]
      ..subject = 'Registro de Jurado ${DateTime.now()}'
      ..html = st;

    try {
      await send(message, smtpServer);
      //  QuickAlert.show(
      //    context: context,
      //    type: QuickAlertType.success,
      //    title: 'Agregado correctamente',
      //    confirmBtnText: 'Hecho',
      //    confirmBtnColor: AppTema.pizazz,
      //  );
      //siAlerta(context);
    } on MailerException catch (e) {
      print(e);
    }
  }

  //*Recuperacion de contraseña
  static Future<void> recuperacionContrasena(
      BuildContext context,
      String correo,
      String contrasena,
      String nombre,
      String apellidoP,
      String apellidoM) async {
    const email = 'nueveseisss@gmail.com';
    const pass = 'wwhxyufesxbankzc';
    final st =
        '<!DOCTYPE html> <html> <head> <title>Bienvenido(a) a InnovaITO</title> <meta charset="UTF-8"> <meta name="viewport" content="width=device-width, initial-scale=1.0"> <style type="text/css"> body { font-family: '
        'Segoe UI'
        ', Tahoma, Geneva, Verdana, sans-serif; background-color: #F9B74E; background-image: linear-gradient(315deg, #F9B74E 0%, #FF9500 74%); } .container { max-width: 600px; margin: 0 auto; padding: 20px; background-color: #FFF; border-radius: 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.3); } .header { text-align: center; margin-bottom: 30px; } .header img { width: 150px; height: 150px; margin-bottom: 20px; } .header h1 { font-size: 36px; color: #FA7A1E; margin-bottom: 5px; } .header p { font-size: 18px; color: #333; margin-bottom: 0; } .info { font-size: 18px; color: #333; margin-bottom: 20px; } .info p { margin-bottom: 10px; } .cta { text-align: center; } .cta a { display: inline-block; background-color: #FA7A1E; color: #FFF; text-decoration: none; font-size: 18px; padding: 10px 20px; border-radius: 5px; transition: all 0.2s ease-in-out; } .cta a:hover { background-color: #F9B74E; color: #FFF; } .footer { text-align: center; margin-top: 50px; font-size: 14px; color: #333; } </style> </head> <body> <div class="container"> <div class="header"> <img src="https://evarafael.com/Aplicacion/logo_innovaITO_negro.png" alt="InnovaITO"> <h2>Solicitud de cambio de contraseña</h2> <p>Hola ${nombre} ${apellidoP} ${apellidoM} ! </p> </div> <div class="info"> <p>Recibimos una solicitud para restablecer la contraseña para su cuenta. ¡Estamos aqui para ayudar!</p> <p>Estos son los datos para su ingreso:</p><p><strong>Correo electrónico:</strong> ${correo}</p> <p><strong>Contraseña:</strong> ${contrasena}</p> <p>Te recomendamos cambiar tu contraseña al iniciar sesión por primera vez para asegurarte de que tu cuenta esté protegida.</p> </div> <div class="cta"> <a href="#">Iniciar sesión</a> </div> <div class="footer"> <p>Este mensaje se envió automáticamente. Por favor, no respondas a este correo electrónico.</p> ';
    final smtpServer = gmail(email, pass);
    final message = Message()
      ..from = const Address(email, 'Kevin')
      ..recipients = [(correo)]
      ..subject = 'Recuperación de contraseña ${DateTime.now()}'
      ..html = st;

    try {
      await send(message, smtpServer);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Correo enviado',
        text: 'Verifique la bandeja de su correo electronico.',
        confirmBtnText: 'Finalizar',
        confirmBtnColor: AppTema.pizazz,
      );
      //siAlerta(context);
    } on MailerException catch (e) {
      print(e);
    }
  }
}
