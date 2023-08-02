import 'package:flutter_riverpod/flutter_riverpod.dart';

final idUsuarioLogin = StateProvider(
  (ref) => "SN",
);

final nombreUsuarioLogin = StateProvider<String>(
  (ref) => "nombres",
);

final nombreRolLogin = StateProvider<String>(
  (ref) => "rol",
);

final inicialesUsuario = StateProvider<String>(
  (ref) => "SN",
);

final idPersona = StateProvider<String>(
  (ref) => "SN",
);
