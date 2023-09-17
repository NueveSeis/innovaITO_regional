import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/helpers/helpers.dart';
import 'package:innova_ito/models/informacionProyectoER.dart';
import 'package:innova_ito/providers/providers.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:http/http.dart' as http;
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class BuscarPresentacionScreen extends ConsumerWidget {
  static const String name = 'BuscarPresentacionScreen';
  BuscarPresentacionScreen({super.key});

  List<InformacionProyectoEr> proyecto = [];
  Future<bool> getProyecto(String foliop) async {
    String url =
        '${dotenv.env['HOST_REST']}get_proyectoWhereRegional.php?Folio=$foliop';

    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        proyecto = informacionProyectoErFromJson(response.body);
        return true;
      } else {
        // print('La solicitud no fue exitosa: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      return false;
      //print('Error al realizar la solicitud: $error');
    }
  }

  final listoAsesor = StateProvider(
    (ref) => false,
  );
  TextEditingController cFolio = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listo = ref.watch(listoAsesor);
    return Scaffold(
        body: FondoGn(
            tituloPantalla: 'Presentación',
            fontSize: 20,
            widget: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    const Text(
                      'Búsqueda de proyecto',
                      style: TextStyle(
                          color: AppTema.bluegrey700,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: formKey,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: cFolio,
                        style: const TextStyle(
                            color: AppTema.bluegrey700,
                            fontWeight: FontWeight.bold),
                        autocorrect: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecorations.registroLiderDecoration(
                          hintText: 'Ingrese el folio del proyecto',
                          labelText: 'Folio del proyecto',
                        ),
                        //onChanged: (value) => registroLider.nombre = value,
                        validator: (value) {
                          return RegexUtil.folioProyecto.hasMatch(value ?? '')
                              ? null
                              : 'Folio no válido.';
                        },
                      ),
                    ),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            child: const Center(
                              child: Text(
                                'Borrar Folio',
                                style: TextStyle(
                                  color: AppTema.grey100,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            onPressed: () {
                              //verAsesor();
                              cFolio.text = '';
                              ref
                                  .read(listoAsesor.notifier)
                                  .update((state) => false);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            child: const Center(
                              child: Text(
                                'Buscar',
                                style: TextStyle(
                                  color: AppTema.grey100,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            onPressed: () {
                              //verAsesor();
                              if (formKey.currentState!.validate()) {
                                // El formulario es válido, realiza la acción deseada aquí
                              } else {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.warning,
                                  title: 'Cuidado',
                                  text: 'Ingresa el folio correctamente',
                                  confirmBtnText: 'Aceptar',
                                  confirmBtnColor: AppTema.pizazz,
                                );
                                // El formulario no es válido, muestra mensajes de error o realiza otras acciones
                              }

                              ref
                                  .read(listoAsesor.notifier)
                                  .update((state) => cFolio.text.isNotEmpty);
                            },
                          ),
                        ),
                      ],
                    ),
                    //verAsesor(),

                    const SizedBox(height: 50),

                    listo
                        ? Column(
                            children: [
                              const Text(
                                'Da clic sobre él proyecto para añadir o modificar su presentación',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppTema.bluegrey700,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              const SizedBox(height: 20),
                              verProyecto(cFolio.text, ref),
                              const SizedBox(height: 20),
                            ],
                          )
                        : const Text(
                            'No has ingresado ningún folio de proyecto',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          ),
                  ],
                ))));
  }

  FutureBuilder<bool> verProyecto(String folioProyecto, WidgetRef ref) {
    //cRFC.dispose();
    return FutureBuilder(
      future: getProyecto(folioProyecto),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          } else {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: proyecto.length,
              itemBuilder: (context, index) {
                //int valor = index + 1;
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    MaterialButton(
                      splashColor: AppTema.pizazz,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 35,
                      elevation: 15.0,
                      color: AppTema.grey100,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            proyecto[index].idFichaTecnica,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppTema.bluegrey700,
                              fontSize: 18.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Proyecto: ${proyecto[index].nombreCorto}',
                            style: const TextStyle(
                              color: AppTema.bluegrey700,
                              fontSize: 15.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Nombre descriptivo: ${proyecto[index].nombreProyecto}',
                            style: const TextStyle(
                              color: AppTema.bluegrey700,
                              fontSize: 15.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Categoría: ${proyecto[index].nombreCategoria}',
                            style: const TextStyle(
                              color: AppTema.bluegrey700,
                              fontSize: 15.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Nivel Academico: ${proyecto[index].nombreNivel}',
                            style: const TextStyle(
                              color: AppTema.bluegrey700,
                              fontSize: 15.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 40, // Altura deseada para el rectángulo
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              child: Container(
                                alignment: Alignment.center,
                                color: proyecto[index].video == null
                                    ? AppTema
                                        .redA400 // Color cuando proyecto[index].video es null
                                    : AppTema
                                        .greenS400, // Color cuando proyecto[index].video no es null
                                child: Text(
                                  proyecto[index].video == null
                                      ? 'Sin Presentación' // Texto cuando proyecto[index].video es null
                                      : 'Con Presentación', // Texto cuando proyecto[index].video no es null
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        ref
                            .read(buscarProyectoRegionalProv.notifier)
                            .update((state) => proyecto[index].idFichaTecnica);
                        context.pushNamed('SubirPresentacionScreen');
                      },
                    ),
                  ],
                );
              },
            );
          }
        } else {
          return const Center(child: Text('¡Algo salió mal!'));
        }
      },
    );
  }
}
