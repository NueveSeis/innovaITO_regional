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
  (ref) => "SN",
);

final folioProyectoUsuarioLogin = StateProvider<String>(
  (ref) => 'SN',
); //PRO5298

final juradoIDProvider = StateProvider<String>(
  (ref) => "SN",
);
final asesorIDProvider = StateProvider<String>(
  (ref) => "SN",
);
