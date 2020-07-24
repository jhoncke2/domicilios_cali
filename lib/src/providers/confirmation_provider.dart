import 'package:http/http.dart' as http;
import 'dart:convert';

class ConfirmationProvider{
  final _apiUrl = 'https://codecloud.xyz/api';

  //*********************************** 
  //  Recuperar contraseña
  //**********************************
  Future<Map<String, dynamic>> enviarCorreoRecuperarPassword(String email)async{
    final passwordResetUrl = '$_apiUrl/password/reset';
    final answer = await http.post(
      passwordResetUrl,
      body: {
        'email':email
      }
    );

    try{
      return json.decode(answer.body);
    }catch(err){
      return {
        'status':'err',
        'message':answer.reasonPhrase
      };
    }
  }

  Future<Map<String, dynamic>> enviarCodigoRecuperarPassword(String email, String code)async{
    final passwordCodeVerifyUrl = '$_apiUrl/password/code/verify';
    final answer = await http.post(
      passwordCodeVerifyUrl,
      body: {
        'email':email,
        'code':code
      }
    );
    try{
      return json.decode(answer.body);
    }catch(err){
      return {
        'status':'err',
        'message':answer.reasonPhrase
      };
    }
      
    
  }

  Future<Map<String, dynamic>> enviarPasswordRecuperarPassword(String email, String password, String passwordConfirmation)async{
    final passwordChangeUrl = '$_apiUrl/password/change';
    final answer = await http.post(
      passwordChangeUrl,
      body:{
        'email':email,
        'password':password,
        'password_confirmation':passwordConfirmation
      }
    );
    try{
      return json.decode(answer.body);
    }catch(err){
      return {
        'status':'err',
        'message':answer.reasonPhrase
      };
    }
  }

  Future<Map<String, dynamic>> resetCode(String token, String tipoConfirmacion, String credencial)async{
    final resetCodeUrl = '$_apiUrl/code/reset/$tipoConfirmacion';
    Map<String, dynamic> body = {};
    if(tipoConfirmacion == 'password')
      body['email']=credencial;
    else
      body['id']=credencial;

    Map<String, String> headers = {};
    if(tipoConfirmacion == 'phone')
      headers['Authorization'] = 'Bearer $token';
    final answer = await http.post(
      resetCodeUrl,
      headers: headers,
      body:body
    );
    try{
      return json.decode(answer.body);
    }catch(err){
      return {
        'status':'err',
        'message':answer.reasonPhrase
      };
    }
  }

  //*********************************** 
  //  Confirmar celular
  //**********************************

  Future<Map<String, dynamic>> enviarCodigoConfirmarPhone(String token, int id, String code)async{
    final conrifmarPhoneUrl = '$_apiUrl/phone/code/verify';
    final answer = await http.post(
      conrifmarPhoneUrl,
      headers: {
        'Authorization':'Bearer $token'
      },
      body:{
        'id':id.toString() ,
        'code': code
      }
    );
    try{
      
      return json.decode(answer.body);
    }catch(err){
      return {
        'status':'err',
        'message':answer.reasonPhrase
      };
    }
  }
}