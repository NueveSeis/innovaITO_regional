import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/screens/screens.dart';

final numParticipantes = StateProvider(
  (ref) => 0,
);

final tipoTecProv = StateProvider<String>((ref) => 'SN');
final tecnologicoProv = StateProvider<String>((ref) => 'SN');
final departamentoProv = StateProvider<String>((ref) => 'SN');
final carreraProv = StateProvider<String>((ref) => 'SN');
final fechaSeleccionadaProv =
    StateProvider<DateTime?>((ref) => DateTime(0000, 0, 0));
final generoProv = StateProvider<String>((ref) => 'SN');
final expectativaProv = StateProvider<String>((ref) => 'SN');
final semestreProv = StateProvider<String>((ref) => 'SN');
final nivelAcademicoProv = StateProvider<String>((ref) => 'SN');
final camposLlenosProv = StateProvider<bool>((ref) => false);

final futureGeneroProv = FutureProvider<List<Genero>>((ref) => obtenerGenero());
final futureExpectativaProv =
    FutureProvider<List<Expectativa>>((ref) => obtenerExpectativa());
final futureSemestreProv =
    FutureProvider<List<Semestre>>((ref) => obtenerSemestre());
final futureNivelProv = FutureProvider<List<Nivel>>((ref) => obtenerNivel());
final futureTipoTecProv =
    FutureProvider<List<TipoTecnologico>>((ref) => obtenerTipoTec());
final futureTecnologicoProv =
    FutureProvider<List<Tecnologico>>((ref) => obtenerTecnologico(ref));
final futureDepartamentoProv =
    FutureProvider<List<Departamento>>((ref) => obtenerDepartamentos(ref));
final futureCarreraProv =
    FutureProvider<List<Carrera>>((ref) => obtenerCarrera(ref));
