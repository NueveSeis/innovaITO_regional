/*import 'package:flutter_riverpod/flutter_riverpod.dart';

final criteriosProvider = StateProvider(
  (ref) => "",
);*/

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innova_ito/models/models.dart';

final criteriosProvider =
    StateNotifierProvider<CriteriosNotifier, List<Criterio>>(
  (ref) => CriteriosNotifier(),
);

class CriteriosNotifier extends StateNotifier<List<Criterio>> {
  CriteriosNotifier() : super([]);

  void addCriterio(Criterio criterio) {
    state = [...state, criterio];
  }
}

class Criterio {
  final String id;
  final String name;
  final double minValue;
  final double maxValue;

  Criterio({
    required this.id,
    required this.name,
    required this.minValue,
    required this.maxValue,
  });
}
