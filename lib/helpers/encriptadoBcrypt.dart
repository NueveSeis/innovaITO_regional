import 'package:bcrypt/bcrypt.dart';
import 'package:dbcrypt/dbcrypt.dart';

class EncriptadoBcrypt{

// Función para encriptar una contraseña con Bcrypt
static String hashContrasena(String contrasena)  {
  final hash = DBCrypt().hashpw(contrasena, DBCrypt().gensalt());
  return hash;
}

// Función para comparar una contraseña en texto plano con una contraseña encriptada con Bcrypt
static bool compararContrasena(String contrasena, String contrasenaHash)  {
  final es =  DBCrypt().checkpw(contrasena, contrasenaHash);
  return es;
}


}


