import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:bcrypt/bcrypt.dart';

class Generar{

 //*generar contraseña random

  static String contrasenaAleatoria() {
    final _random = Random.secure();
    const _caracteres = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#\$*-_+\\|./?';
    return String.fromCharCodes(Iterable.generate(
        8, (_) => _caracteres.codeUnitAt(_random.nextInt(_caracteres.length))));
  }


 //* generar ID unico para persona mediante el nombre completo y correo electronico

 static String idPersona(String nombres, String apellidoPaterno, String apellidoMaterno, String correo) {
    String datosUsuario = '$nombres$apellidoPaterno$apellidoMaterno$correo';
    String idGenerada = sha1.convert(utf8.encode(datosUsuario)).toString().substring(0,10);
  return idGenerada.toLowerCase();
}


  //* generar hash de contraseña en BCRYPT
  static String hashContrasena(String contrasena)  {
    final hash = BCrypt.hashpw(contrasena, BCrypt.gensalt(),);
    return hash;
  }


  //* funcion para comparar una contraseña en texto plano con una contraseña encriptada con Bcrypt
  static bool compararContrasena(String contrasena, String contrasenaHash)  {
    final es =  BCrypt.checkpw(contrasena, contrasenaHash);
    return es;
  }

}