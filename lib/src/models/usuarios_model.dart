import 'dart:core';
//importaciones locales

class UsuariosModel{
  List<UsuarioModel> _usuarios = new List();
  /* ***********************************************
   *    Pruebas
   *********************************************** */
  UsuariosModel.fromJsonList(List<dynamic> jsonList){
    jsonList.forEach((actual){
      final usuarioActual = UsuarioModel.fromJsonMap(actual);
      usuarios.add(usuarioActual);
    });
  }

  List<UsuarioModel> get usuarios{
    return _usuarios;
  }
}

class UsuarioModel{
  int id;
  String name;
  String email;
  String imagenUrl;

  UsuarioModel({
    this.id,
    this.name,
    this.email,
    //en proceso
    //this.imagenUrl
  });

  UsuarioModel.fromJsonMap(Map<String, dynamic> json){
    id          = json['id'];
    name        = json['name'];
    email       = json['email'];
    //en proceso
    //imagenUrl   = json['imagen_url'];
  }

  @override
  String toString(){
    return '{\nid:${this.id},\nname:${this.name},\nemail.${this.email}\n}';
  }
}