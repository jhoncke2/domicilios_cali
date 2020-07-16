import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UsuarioProvider{
  final _apiUrl = 'https://codecloud.xyz/api';

  Future<Map<String, dynamic>> register(String name, String email, String phone, String password, String passwordConfirmation)async{
    final answer = await http.post(
      '$_apiUrl/register',
      body:{
        'name':name,
        'email':email,
        'phone':phone,
        'password':password,
        'password_confirmation':passwordConfirmation
      }
    );
    if(answer.body != null)
      return json.decode(answer.body);
    return {
      'status':'err',
      'message':'ocurrió algún error al tratar de crear el usuario'
    };
  }


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
      '$_apiUrl/logout',
      body: {
        "token":token
      }
    );
    Map<String, dynamic> decodedMap = json.decode(respuesta.body);
    return decodedMap;
  }

  Future<Map<String, dynamic>> getUserByToken(String token)async{
    final respuesta = await http.get(
      '$_apiUrl/seeUserAuth',
      headers: {
        "Authorization": 'Bearer $token'
      }
    );
    Map<String, dynamic> decodedResp = json.decode(respuesta.body)['data'];
    return decodedResp;
  }

  Future<Map<String, dynamic>> cambiarNombreYAvatar(String token, int perfilId, String name, File avatar)async{
    Map<String, String> headers = {
      'Authorization':'Bearer $token',
      'Content-Type':'application/x-www-form-urlencoded'
    };

    var request = http.MultipartRequest('POST', Uri.parse('$_apiUrl/perfil/update'));
    if(avatar != null){
      request.files.add(
        http.MultipartFile(
          'avatar',
          avatar.readAsBytes().asStream(),
          avatar.lengthSync(),
          filename: avatar.path.split('/').last
        )
      );
    }
    request.fields.addAll({
      'name':name
    });

    request.headers.addAll(headers);
    final streamResponse = await request.send();
    final response = await http.Response.fromStream(streamResponse);
    try{
      Map<String, dynamic> decodedResponse = json.decode(response.body);
      return {
        'status':'ok',
        'tienda':decodedResponse['tienda']
      };
    }catch(err){
      return {
        'status':'err',
        'message':err
      };
    }
  }

  Future<Map<String, dynamic>> cambiarFoto(String token, File foto)async{
    return null;
  }

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

    if(answer.body != null)
      return json.decode(answer.body);
    return {
      'status':'err',
      'message':answer.reasonPhrase
    };
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
    if(answer.body != null)
      return json.decode(answer.body);
    return {
      'status':'err',
      'message':answer.reasonPhrase
    };
  }

  Future<Map<String, dynamic>> enviarPasswordRecuperarPassword(String email, String password, String passwordConfirmation)async{
    final passwordChangeUrl = '$_apiUrl/password/change';
    final answer = await http.post(
      passwordChangeUrl,
      body:{
        'email':email,
        'password':password,
        'passwordConfirmation':passwordConfirmation
      }
    );
    if(answer.body != null)
      return json.decode(answer.body);
    return {
      'status':'err',
      'message':answer.reasonPhrase
    };
  }
}