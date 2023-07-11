import 'package:flutter_riverpod/flutter_riverpod.dart';

final idUsuarioLogin = StateProvider(
  (ref) => "sin datos",
);

final nombreUsuarioLogin = StateProvider<String>(
  (ref) => "nombres",
);

final nombreRolLogin = StateProvider<String>(
  (ref) => "rol",
);
