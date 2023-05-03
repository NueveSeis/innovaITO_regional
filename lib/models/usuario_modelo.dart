class UsuarioModelo{
  final Id_usuario;
  final Nombre_usuario;
  final Contrasena;
  final Id_persona;
  final Id_rol;

  UsuarioModelo({
    this.Id_usuario,
    this.Nombre_usuario,
    this.Contrasena,
    this.Id_persona,
    this.Id_rol
  }
  );

  //En esta parte se leeran loos datos del json por que estan encoded para json 

  factory UsuarioModelo.fromJson(Map<String,dynamic> json){
    return UsuarioModelo(
      Id_persona: json['Id_persona'],
      Nombre_usuario: json['Nombre_usuario'],
      Contrasena: json['Contrasena'],
      Id_usuario: json['Id_usuario'],
      Id_rol: json['Id_rol']
    );

  }

}