import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innova_ito/widgets/widgets.dart';

import '../providers/criterios_provider.dart';

class CriteriosScreen extends ConsumerWidget {
  static const String name = 'criterios';
  CriteriosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final criterios = ref.watch(criteriosProvider);

    return Scaffold(
      body: Fondo(
        tituloPantalla: 'Criterios',
        fontSize: 20,
        widget: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              /*ListView.builder(
                itemCount: criterios.length,
                itemBuilder: (context, index) {
                  final criterio = criterios[index];
                  return ListTile(
                    title: Text('criterio.name'),
                    subtitle: Text(
                      'Min: {criterio.minValue} | Max: {criterio.maxValue}%',
                    ),
                  );
                },
              ),*/
              if (criterios.isNotEmpty) // Check if the list is not empty
                Expanded(
                  child: ListView.builder(
                    itemCount: criterios.length,
                    itemBuilder: (context, index) {
                      final criterio = criterios[index];
                      return ListTile(
                        title: Text(criterio.name),
                        subtitle: Text(
                          'Min: ${criterio.minValue} | Max: ${criterio.maxValue}%',
                        ),
                      );
                    },
                  ),
                ),
              ElevatedButton(
                onPressed: () {
                  // Show a dialog to create a new rubric
                  _showCreateRubricDialog(ref, context);
                },
                child: const Text('Agregar Rubrica'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createRubric(WidgetRef ref, BuildContext context, String rubricName,
      double minValue, double maxValue) {
    if (rubricName.isNotEmpty && minValue <= maxValue) {
      ref.read(criteriosProvider.notifier).addCriterio(
            Criterio(
              id: DateTime.now().toString(),
              name: rubricName,
              minValue: minValue,
              maxValue: maxValue,
            ),
          );
      Navigator.pop(context);
    }
  }

  void _showCreateRubricDialog(WidgetRef ref, BuildContext context) {
    String rubricName = '';
    double minValue = 0;
    double maxValue = 0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Crear Rubrica'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Nombre de la Rubrica'),
                onChanged: (value) => rubricName = value,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Valor Mínimo'),
                keyboardType: TextInputType.number,
                onChanged: (value) => minValue = double.tryParse(value) ?? 0,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Valor Máximo (%)'),
                keyboardType: TextInputType.number,
                onChanged: (value) => maxValue = double.tryParse(value) ?? 0,
              ),
              const SizedBox(height: 10),
              Text(
                'Suma de Valores Máximos: ${_calculateTotalMax(ref, maxValue)}%',
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Validate and save the rubric
                _createRubric(ref, context, rubricName, minValue,
                    maxValue); // Call the function
                /*if (rubricName.isNotEmpty && minValue <= maxValue) {
                  ref.read(criteriosProvider.notifier).addCriterio(
                        Criterio(
                          id: DateTime.now().toString(),
                          name: rubricName,
                          minValue: minValue,
                          maxValue: maxValue,
                        ),
                      );
                  Navigator.pop(context);
                }*/
              },
              child: const Text('Crear'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  double _calculateTotalMax(WidgetRef ref, double newValue) {
    final criterios = ref.watch(criteriosProvider);
    double totalMax = 0;
    for (final criterio in criterios) {
      totalMax += criterio.maxValue;
    }
    totalMax += newValue;
    return totalMax;
  }
}
