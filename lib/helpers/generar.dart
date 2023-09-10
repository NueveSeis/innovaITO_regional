import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:bcrypt/bcrypt.dart';

class Generar {
//   //*generar contraseña random

//   static String contrasenaAleatoria() {
//     final caracteresPermitidos = '@#\$*-_+\\|./?';
//     final random = Random();

//     String generarCaracter(String opciones) {
//       final indice = random.nextInt(opciones.length);
//       return opciones[indice];
//     }

//     String contrasena = '';
//     contrasena +=
//         generarCaracter('@#\$*-_+\\|./?'); // Agregar un carácter permitido
//     contrasena += generarCaracter(
//         'abcdefghijklmnopqrstuvwxyz'); // Agregar una letra minúscula
//     contrasena += generarCaracter(
//         'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Agregar una letra mayúscula
//     contrasena += generarCaracter('0123456789'); // Agregar un dígito numérico

//     // Generar el resto de la contraseña
//     for (var i = 0; i < 4; i++) {
//       contrasena += generarCaracter('@#\$*-_+\\|./?' +
//           'abcdefghijklmnopqrstuvwxyz' +
//           'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
//           '0123456789');
//     }

//     // Mezclar los caracteres para mayor aleatoriedad
//     final caracteres = contrasena.split('');
//     caracteres.shuffle();
//     contrasena = caracteres.join('');

//     return contrasena;
//   }

  // static String contrasenaAleatoria() {
  //   final _random = Random.secure();
  //   const _caracteres = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#\$*-_+\\|./?';
  //   return String.fromCharCodes(Iterable.generate(
  //       8, (_) => _caracteres.codeUnitAt(_random.nextInt(_caracteres.length))));
  // }

  static String contrasenaAleatoria() {
    final caracteresPermitidos = '@#\$*-_+\\|./?';
    final random = Random();

    String generarCaracter(String opciones) {
      final indice = random.nextInt(opciones.length);
      return opciones[indice];
    }

    String contrasena = '';
    contrasena +=
        generarCaracter(caracteresPermitidos); // Agregar un carácter especial
    contrasena += generarCaracter(
        'abcdefghijklmnopqrstuvwxyz'); // Agregar una letra minúscula
    contrasena += generarCaracter(
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Agregar una letra mayúscula
    contrasena += generarCaracter('0123456789'); // Agregar un dígito numérico

    // Generar el resto de la contraseña
    final longitud = random.nextInt(13) + 8; // Longitud aleatoria entre 8 y 20
    for (var i = 4; i < longitud; i++) {
      contrasena += generarCaracter('@#\$*-_+\\|./?' +
          'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
    }

    // Mezclar los caracteres para mayor aleatoriedad
    final caracteres = contrasena.split('');
    caracteres.shuffle();
    contrasena = caracteres.join('');

    return contrasena;
  }

  //* generar ID unico para persona mediante el nombre completo y correo electronico

  static String idPersona(String nombres, String apellidoPaterno,
      String apellidoMaterno, String correo) {
    String datosUsuario = '$nombres$apellidoPaterno$apellidoMaterno$correo';
    String idGenerada =
        sha1.convert(utf8.encode(datosUsuario)).toString().substring(0, 10);
    return idGenerada.toLowerCase();
  }

  //* generar hash de contraseña en BCRYPT
  static String hashContrasena(String contrasena) {
    final hash = BCrypt.hashpw(
      contrasena,
      BCrypt.gensalt(),
    );
    return hash;
  }

  //* funcion para comparar una contraseña en texto plano con una contraseña encriptada con Bcrypt
  static bool compararContrasena(String contrasena, String contrasenaHash) {
    final es = BCrypt.checkpw(contrasena, contrasenaHash);
    return es;
  }

//*Generar id unico para proyectos
  static String idProyecto(String nombre) {
    DateTime fecha = DateTime.now(); //obtener fecha actual
    String ano = (fecha.year % 100).toString().padLeft(2,
        '0'); //obtiene el año actual y se toman los dos últimos dígitos usando el operador % 100
    String mes = fecha.month.toString().padLeft(2, '0');
    String dia = fecha.day.toString().padLeft(2, '0');

    String hash =
        sha1.convert(utf8.encode(nombre)).toString(); //se convierte a sha1
    String digitosNombre = hash.replaceAll(RegExp(r'\D'), '').substring(0,
        5); //para eliminar todos los caracteres que no sean dígitos y se toman los primeros 5 digitos

    String id = '$ano$mes$dia$digitosNombre';
    return id;
  }
}
