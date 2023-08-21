import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innova_ito/models/models.dart';

// final idJuezSLProv = StateProvider(
//   (ref) => "SN",
// );

final proyectoDatosPESS =
    StateProvider<List<EvaluacionProJuradoSala>>((ref) => []);

final proyectoDatosPESST =
    StateProvider<List<EvaluacionProJuradoStand>>((ref) => []);
