class RegexUtil {
  static final RegExp correoEdu = RegExp(
      r'^[\w-\.]+@(?:[a-zA-Z0-9][a-zA-Z0-9-]+\.)+(edu\.mx|TECNM\.MX|tecnm\.mx|EDU\.MX)$');

  static final RegExp correo = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static final RegExp contrasena = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#\$*\-_+\|./?])[A-Za-z\d@#\$*\-_+\|./?]{8,20}$',
  );

  static final RegExp nombres = RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)?$');

  static final RegExp matricula = RegExp(r'^[a-zA-Z0-9]+$');

  static final RegExp titulo =
      RegExp(r'^([a-zA-Z]+\.{0,1} *[a-zA-Z]*\.*){1,3}$');

  static final RegExp rfc = RegExp(
      r'^([A-ZÑ]{3,4})(\d{2})(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])([A-Z\d]{2})([A\d])$');

  static final RegExp curp = RegExp(r'^[A-Z]{4}\d{6}[H,M][A-Z]{5}\w\d$');

  static final RegExp ine = RegExp(r'^\d{13}$');

  static final RegExp telefono = RegExp(r'^\d{10}$');

  static final RegExp carrera = RegExp(r'^([a-zA-ZáéíóúÁÉÍÓÚñÑ]+\s{0,1})+$');

  static final RegExp datos = RegExp(r'^\s*$');

  static final RegExp promedio = RegExp(r'^\d+(\.\d{1,2})?$');
}
