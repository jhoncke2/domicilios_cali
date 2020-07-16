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
  String avatar;
  String phone;
  bool phoneVerify;

  UsuarioModel({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.phone,
    this.phoneVerify,
  });

  UsuarioModel.fromJsonMap(Map<String, dynamic> json){
    
    id            = json['id'];
    name          = json['name'];
    email         = json['email'];
    _formatAvatar(json['avatar']);
    phone         = json['phone'].toString();
    phoneVerify   = (json['phone_verify']==1)? true : false;

  }

  void _formatAvatar(String serverUrl){
    String urlBase = 'https://codecloud.xyz';
    //serverUrl = serverUrl.replaceFirst('public', '');
    avatar = urlBase + serverUrl;

  }

  @override
  String toString(){
    return '{\nid:${this.id},\nname:${this.name},\nemail.${this.email}\n}';
  }
}