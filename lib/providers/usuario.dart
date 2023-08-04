import 'package:flutter_riverpod/flutter_riverpod.dart';

final idUsuarioLogin = StateProvider(
  (ref) => "SN",
);

final nombreUsuarioLogin = StateProvider<String>(
  (ref) => "SN",
);

final nombreRolLogin = StateProvider<String>(
  (ref) => "SN",
);

final inicialesUsuario = StateProvider<String>(
  (ref) => "SN",
);

final idPersona = StateProvider<String>(
  (ref) => "SN",
);

final matriculaProvider = StateProvider<String>(
  (ref) => "19161250",
);

final folioProyectoUsuarioLogin = StateProvider(
  (ref) => 'PRO2601',
);
