import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innova_ito/models/models.dart';

final idJuezSLProv = StateProvider(
  (ref) => "SN",
);

final idAreaSLProv = StateProvider<String>(
  (ref) => "SN",
);

final idCatSLProv = StateProvider<String>(
  (ref) => "SN",
);

final juradoDatosSL = StateProvider<List<ProyectosJuradoAsjs>>((ref) => []);

//final futureGeneroProv = FutureProvider<List<ProyectosJuradoAsjs>>((ref) => );
