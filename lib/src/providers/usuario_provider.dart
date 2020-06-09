import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:domicilios_cali/src/models/usuarios_model.dart';
import 'package:domicilios_cali/src/utils/data_prueba/usuarios_prueba.dart';
import 'dart:convert';

class UsuarioProvider with UsuariosPrueba{
  final _apiUrl = 'https://codecloud.xyz/api';

  UsuarioProvider(){
    
  }

  @override
  // TODO: implement usuarios
  List<Map<String, Object>> get usuarios => super.usuarios;

  Future<Map<String, dynamic>> login( String email, String password)async{
    final loginUrl = '$_apiUrl/login';
    final respuesta = await http.post(
      loginUrl,
      body: {
        "email":email,
        "password":password
      }
    );
    Map<String, dynamic> decodedResp = json.decode(respuesta.body);
    return decodedResp;
  }

  Future<Map<String, dynamic>> logOut(String token)async{
    final respuesta = await http.post(
      '${_apiUrl}/logout',
      body: {
        "token":'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvY29kZWNsb3VkLnh5elwvYXBpXC9sb2dpbiIsImlhdCI6MTU4OTU2NDA5OCwiZXhwIjoxNTg5NTY3Njk4LCJuYmYiOjE1ODk1NjQwOTgsImp0aSI6InN0Sndubkk5QnB3N1JOZjgiLCJzdWIiOjEsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.thJ9q1SjMKEKoljEIxnzULmQXYhPx6h2D_G98dnhu54'
      }
    );
    Map<String, dynamic> decodedMap = json.decode(respuesta.body);
    return decodedMap;
  }

  Future<Map<String, dynamic>> getUserByToken(String token)async{
    final respuesta = await http.get(
      '${_apiUrl}/seeUserAuth',
      headers: {
        "Authorization": 'Bearer $token'
      }
    );
    Map<String, dynamic> decodedResp = json.decode(respuesta.body);
    return decodedResp;
  }

  Future<Map<String, dynamic>> register(String name, String email, String password)async{
    final answer = await http.post(
      '$_apiUrl/register',
      body:{
        'name':name,
        'email':email,
        'password':password
      }
    );
    if(answer.body != null)
      return json.decode(answer.body);
    return {
      'status':'ok',
      'message':'ocurrió algún error al tratar de crear el usuario'
    };
  }

  Future<Map<String, dynamic>> cambiarFoto(String token, File foto)async{
    return null;
  }
  

  //prueba
  Usuario get usuarioLoginPrueba => Usuario.fromJsonMap(super.usuarios[0]);

}