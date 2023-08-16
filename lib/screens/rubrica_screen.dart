import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/widgets/widgets.dart';

import 'package:http/http.dart' as http;

class RubricaScreen extends ConsumerWidget {
  static const String name = 'rubrica';
  RubricaScreen({super.key});

  List<Genero> genero = [];

  Future<void> getGenero(WidgetRef ref) async {
    String url = 'https://evarafael.com/Aplicacion/rest/get_genero.php';
    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        genero = generoFromJson(response.body);
      } else {
        print('La solicitud no fue exitosa: ${response.statusCode}');
      }
    } catch (error) {
      print('Error al realizar la solicitud: $error');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Fondo(
          tituloPantalla: 'Rubrica',
          fontSize: 20,
          widget: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [],
            ),
          )),
    );
  }
}
