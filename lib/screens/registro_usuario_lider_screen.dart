import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;



import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/theme/cambiar_tema.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:innova_ito/helpers/helpers.dart';


class RegistroUsuarioLiderScreen extends StatefulWidget {
  const RegistroUsuarioLiderScreen({super.key});

  @override
  State<RegistroUsuarioLiderScreen> createState() => _RegistroUsuarioLiderScreenState();
}

class _RegistroUsuarioLiderScreenState extends State<RegistroUsuarioLiderScreen> {

  TextEditingController nivel = TextEditingController();
  TextEditingController matricula = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController apellidoP = TextEditingController();
  TextEditingController apellidoM = TextEditingController();
  TextEditingController correo = TextEditingController();
  String contrasena = '';
  String id = '';
  String contrasenaHash = '';
  bool existePersona=false;

  Future agregarPersona()async {
    var url = 'https://evarafael.com/Aplicacion/rest/agregarLider.php';
    await http.post(Uri.parse(url),body: {
      'Id_persona' : id,
      'Nombre_persona' : nombre.text.toUpperCase(),
      'Apellido1' : apellidoP.text.toUpperCase(),
      'Apellido2' : apellidoM.text.toUpperCase(),
      'Correo_electronico' : correo.text.toUpperCase(),
      'Id_usuario': id,
      'Nombre_usuario' : correo.text.toUpperCase(),
      'Contrasena': contrasenaHash,
      'Id_rol': 'ROL02',
      'Matricula' : matricula.text.toUpperCase(),
    });
  }

  Future existente() async{
    String  url = 'https://evarafael.com/Aplicacion/rest/existePersona.php';
    var response = await http.post(Uri.parse(url), body: {
      'Id_persona': id,
    });

    var data = json.decode(response.body);
    if(data == "Realizado"){
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Usuario existente',
        confirmBtnText: 'Hecho',
        confirmBtnColor: AppTema.pizazz,
      );
    }else{
      agregarPersona();
      Correo.registroLider(context, correo.text.toUpperCase(), contrasena, nombre.text.toUpperCase(), apellidoP.text.toUpperCase(), apellidoM.text.toUpperCase());
    }
  }
  

  @override
  Widget build(BuildContext context) {
    final temaApp = Provider.of<CambiarTema>(context);
    return Scaffold(
        body: Fondo(
            tituloPantalla: 'Registro lider de proyecto',
            fontSize: 20,
            widget: Column(
              children: [
                const SizedBox(height: 50),
                Text(
                  'Ingrese datos del estudiante',
                  style: TextStyle(
                      color: (temaApp.temaOscuro)
                          ? Colors.white
                          : CambiarTema.balticSea,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Form(
                      child: Column(
                    children: [
                      const SizedBox(height: 20),
                      DropdownButtonFormField(
                            
                          value: 'Licenciatura',
                          style: const TextStyle(
                              color: CambiarTema.bluegrey700,
                              fontWeight: FontWeight.bold),
                          items: const [
                            DropdownMenuItem(
                              value: 'Licenciatura',
                              child: Text('Licenciatura'),
                            ),
                            DropdownMenuItem(
                              value: 'Postgrado',
                              child: Text('Postgrado'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              nivel.text = value.toString();
                            });
                            
                            print(nivel);
                          }),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: matricula,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                            color: CambiarTema.bluegrey700,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecorations.registroLiderDecoration(
                          hintText: 'Ingrese matricula',
                          labelText: 'Matricula',

                          //prefixIcon: Icons.person
                        ),
                        //onChanged: (value) => accesoFormulario.correo = value,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: nombre,
                        style: const TextStyle(
                            color: CambiarTema.bluegrey700,
                            fontWeight: FontWeight.bold),
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecorations.registroLiderDecoration(
                          hintText: 'Ingrese nombre(s)',
                          labelText: 'Nombre(s)',
                          //prefixIcon: Icons.person
                        ),
                        //onChanged: (value) => accesoFormulario.correo = value,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: apellidoP,
                        style: const TextStyle(
                            color: CambiarTema.bluegrey700,
                            fontWeight: FontWeight.bold),
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecorations.registroLiderDecoration(
                          hintText: 'Ingrese apellido paterno',
                          labelText: 'Apellido paterno',
                          //prefixIcon: Icons.person
                        ),
                        //onChanged: (value) => accesoFormulario.correo = value,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: apellidoM,
                        style: const TextStyle(
                            color: CambiarTema.bluegrey700,
                            fontWeight: FontWeight.bold),
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecorations.registroLiderDecoration(
                          hintText: 'Ingrese apellido materno',
                          labelText: 'Apellido materno',
                          //prefixIcon: Icons.person
                        ),
                        //onChanged: (value) => accesoFormulario.correo = value,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: correo,
                        style: const TextStyle(
                            color: CambiarTema.bluegrey700,
                            fontWeight: FontWeight.bold),
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecorations.registroLiderDecoration(
                          hintText: 'Ingrese correo electronico',
                          labelText: 'Correo electronico',
                          //prefixIcon: Icons.person
                        ),
                        //onChanged: (value) => accesoFormulario.correo = value,
                      ),
//                      SizedBox(height: 20),
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
                                color: CambiarTema.grey100, fontSize: 25),
                          )),
                          onPressed: () {
                             FocusScope.of(context).requestFocus(FocusNode());
                            id = Generar.idPersona(nombre.text.toUpperCase(), apellidoP.text.toUpperCase(), apellidoM.text.toLowerCase(), correo.text.toUpperCase());
                            contrasena = Generar.contrasenaAleatoria();
                            contrasenaHash = Generar.hashContrasena(contrasena);
                            existente();
                          },
                        ),
                      ),
                    ],
                  )),
                ),
              ],
            )));
  }  
}
