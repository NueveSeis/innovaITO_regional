import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innova_ito/helpers/helpers.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';

class AgregarParticipanteScreen extends ConsumerWidget {
  static const String name = 'agregar_participantes';
  DateTime _selectedDateTime = DateTime.now();

  AgregarParticipanteScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //TextEditingController nivel = TextEditingController();
  TextEditingController cMatricula = TextEditingController();
  TextEditingController cNombre = TextEditingController();
  TextEditingController cApellidoP = TextEditingController();
  TextEditingController cApellidoM = TextEditingController();
  TextEditingController cCorreo = TextEditingController();
  TextEditingController cPromedio = TextEditingController();
  TextEditingController cNumero = TextEditingController();
  TextEditingController cCurp = TextEditingController();
  TextEditingController cIne = TextEditingController();
  String contrasena = '';
  String id = '';
  String contrasenaHash = '';
  bool existePersona = false;
  String idNivel = '';
  bool camposLlenos = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Fondo(
            tituloPantalla: 'Registro de participante',
            fontSize: 20,
            widget: Column(
              children: [
                const SizedBox(height: 50),
                Text(
                  'Ingrese datos del estudiante',
                  style: TextStyle(
                      color: AppTema.balticSea,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Form(
                      //autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          DropdownButtonFormField(
                              value: 'Seleccione una opción',
                              style: const TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Seleccione una opción',
                                  child: Text('Seleccione una opción'),
                                ),
                                DropdownMenuItem(
                                  value: 'Licenciatura',
                                  child: Text('Licenciatura'),
                                ),
                                DropdownMenuItem(
                                  value: 'Posgrado',
                                  child: Text('Posgrado'),
                                ),
                              ],
                              onChanged: (value) {}),
                          const SizedBox(height: 20),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: cNombre,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese nombre(s)',
                              labelText: 'Nombre(s)',
                            ),
                            //onChanged: (value) => registroLider.nombre = value,
                            validator: (value) {
                              return RegexUtil.nombres.hasMatch(value ?? '')
                                  ? null
                                  : 'Nombre no valido.';
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: cApellidoP,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese apellido paterno',
                              labelText: 'Apellido paterno',
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: cApellidoM,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese apellido materno',
                              labelText: 'Apellido materno',
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: cMatricula,
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese matricula',
                              labelText: 'Matricula',
                            ),
                            validator: (value) {
                              return RegexUtil.matricula.hasMatch(value ?? '')
                                  ? null
                                  : 'Matricula no valida.';
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: cPromedio,
                            autocorrect: false,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese promedio',
                              labelText: 'Promedio',
                            ),
                            validator: (value) {
                              return RegexUtil.promedio.hasMatch(value ?? '')
                                  ? null
                                  : 'Promedio no valido.';
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: cCurp,
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese CURP',
                              labelText: 'CURP',
                            ),
                            validator: (value) {
                              return RegexUtil.curp.hasMatch(value ?? '')
                                  ? null
                                  : 'CURP no valida.';
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: cIne,
                            autocorrect: false,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese No. de credencial INE',
                              labelText: 'No. Cred. INE',
                            ),
                            validator: (value) {
                              return RegexUtil.ine.hasMatch(value ?? '')
                                  ? null
                                  : 'Credencial no valida.';
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: cCorreo,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese correo electronico',
                              labelText: 'Correo electronico',
                            ),
                            validator: (value) {
                              return RegexUtil.correoEdu.hasMatch(value ?? '')
                                  ? null
                                  : 'Solo se acepta correo institucional.';
                            },
                          ),
                          const SizedBox(height: 20),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Género',
                              style: TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField(
                              value: 'Seleccione una opción',
                              style: const TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Seleccione una opción',
                                  child: Text('Seleccione una opción'),
                                ),
                                DropdownMenuItem(
                                  value: 'MASCULINO',
                                  child: Text('Masculino'),
                                ),
                                DropdownMenuItem(
                                  value: 'FEMENINO',
                                  child: Text('Femenino'),
                                ),
                              ],
                              onChanged: (value) {}),
                          const SizedBox(height: 20),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Expectativa',
                              style: TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField(
                              value: 'Seleccione una opción',
                              style: const TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Seleccione una opción',
                                  child: Text('Seleccione una opción'),
                                ),
                                DropdownMenuItem(
                                  value: 'MASCULINO',
                                  child: Text('Masculino'),
                                ),
                                DropdownMenuItem(
                                  value: 'FEMENINO',
                                  child: Text('Femenino'),
                                ),
                              ],
                              onChanged: (value) {}),
                          const SizedBox(height: 20),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Semestre',
                              style: TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField(
                              value: 'Seleccione una opción',
                              style: const TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Seleccione una opción',
                                  child: Text('Seleccione una opción'),
                                ),
                                DropdownMenuItem(
                                  value: 'MASCULINO',
                                  child: Text('Masculino'),
                                ),
                                DropdownMenuItem(
                                  value: 'FEMENINO',
                                  child: Text('Femenino'),
                                ),
                              ],
                              onChanged: (value) {}),
                          const SizedBox(height: 20),
                          Center(
                              child: ElevatedButton(
                            child: const Text('Seleccione fecha de nacimiento'),
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                locale: const Locale("es", "ES"),
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2024),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                        primary: AppTema.pizazz,
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                            primary: AppTema
                                                .pizazz // button text color
                                            ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                            },
                          )),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: cNumero,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold),
                            autocorrect: false,
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecorations.registroLiderDecoration(
                              hintText: 'Ingrese Numero telefonico',
                              labelText: 'Numero telefonico',
                            ),
                            validator: (value) {
                              return RegexUtil.telefono.hasMatch(value ?? '')
                                  ? null
                                  : 'Solo se aceptan numeros.';
                            },
                          ),
                          const SizedBox(height: 20),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Nivel academico',
                              style: TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField(
                              value: 'Seleccione una opción',
                              style: const TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Seleccione una opción',
                                  child: Text('Seleccione una opción'),
                                ),
                                DropdownMenuItem(
                                  value: 'MASCULINO',
                                  child: Text('Masculino'),
                                ),
                                DropdownMenuItem(
                                  value: 'FEMENINO',
                                  child: Text('Femenino'),
                                ),
                              ],
                              onChanged: (value) {}),
                          const SizedBox(height: 20),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Carrera',
                              style: TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField(
                              value: 'Seleccione una opción',
                              style: const TextStyle(
                                  color: AppTema.bluegrey700,
                                  fontWeight: FontWeight.bold),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Seleccione una opción',
                                  child: Text('Seleccione una opción'),
                                ),
                                DropdownMenuItem(
                                  value: 'MASCULINO',
                                  child: Text('Masculino'),
                                ),
                                DropdownMenuItem(
                                  value: 'FEMENINO',
                                  child: Text('Femenino'),
                                ),
                              ],
                              onChanged: (value) {}),
                          const SizedBox(height: 20),
                          Container(
                            height: 50,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: ElevatedButton(
                              child: const Center(
                                  //height: 50,
                                  child: Text(
                                'Registrar',
                                style: TextStyle(
                                    color: AppTema.grey100, fontSize: 25),
                              )),
                              onPressed: () async {},
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            )));
  }
}
