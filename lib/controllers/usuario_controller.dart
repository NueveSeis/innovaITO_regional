import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:innova_ito/models/models.dart';

class UsuarioController{

  //Aqui iran los metodos para obtener,actualizar,borrar y agregar, basicamente el crud

  List<UsuarioModelo> usuariosFromJSON(String jsonstring){
    final data = json.decode(jsonstring);
    return List<UsuarioModelo>.from(data.map((item)=>UsuarioModelo.fromJson(item)));
  }


  Future<List<UsuarioModelo>> getUsuario() async{
    String view_ip = "http://localhost/rest/prueba.php";
    final response = await http.get(Uri.parse(view_ip));
    if(response.statusCode == 200){
      List<UsuarioModelo> list = usuariosFromJSON(response.body);
      return list;
    }else{
      return <UsuarioModelo>[];
    }
  }
}