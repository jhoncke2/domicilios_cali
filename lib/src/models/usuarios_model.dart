import 'dart:core';
//importaciones locales

class Usuarios{
  List<Usuario> _usuarios = new List();
  /* ***********************************************
   *    Pruebas
   *********************************************** */
  Usuarios.fromJsonList(List<dynamic> jsonList){
    jsonList.forEach((actual){
      final usuarioActual = Usuario.fromJsonMap(actual);
      usuarios.add(usuarioActual);
    });
  }

  List<Usuario> get usuarios{
    return _usuarios;
  }
}

class Usuario{
  int id;
  String name;
  String email;
  String imagenUrl;

  Usuario({
    this.id,
    this.name,
    this.email,
    //en proceso
    //this.imagenUrl
  });

  Usuario.fromJsonMap(Map<String, dynamic> json){
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