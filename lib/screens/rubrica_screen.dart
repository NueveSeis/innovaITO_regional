import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'dart:convert';
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
    return Scaffold(
      body: Fondo(
          tituloPantalla: 'Rubrica',
          fontSize: 20,
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [],
            ),
          )),
    );
  }
}
