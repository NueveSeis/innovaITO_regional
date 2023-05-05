class RegexUtil{

  static final RegExp correoEdu = RegExp(r'^[\w-\.]+@(?:[a-zA-Z0-9][a-zA-Z0-9-]+\.)+(edu\.mx|TECNM\.MX)$');

  static final RegExp correo = RegExp( r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static final RegExp contrasena = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$*\-_+|./?])[A-Za-z\d@#$*\-_+|./?]{8,}$');

  static final RegExp nombres = RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)?$');

  static final RegExp matricula = RegExp(r'^[a-zA-Z0-9]+$');
}