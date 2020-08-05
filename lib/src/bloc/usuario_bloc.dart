import 'dart:io';
import 'package:rxdart/rxdart.dart';

import 'package:domicilios_cali/src/models/usuarios_model.dart';
import 'package:domicilios_cali/src/providers/usuario_provider.dart';
import 'package:domicilios_cali/src/providers/push_notifications_provider.dart';
class UsuarioBloc{
  final _usuarioProvider = new UsuarioProvider();

  final _usuarioController = new BehaviorSubject<List<UsuarioModel>>();
  
  UsuarioModel usuario;
  String token;

  Stream<List<UsuarioModel>> get usuarioStream => _usuarioController.stream;

  Future<Map<String, dynamic>> login(String email, String password)async{
    Map<String, dynamic> respuesta = await _usuarioProvider.login(email, password);
    if(respuesta['status']=='ok'){
      token = respuesta['token'];
      await cargarUsuario(token);
      return{
        'status':'ok',
        'token':token,
        'user':usuario,
      };
    }
    return respuesta;
  }

  Future<Map<String, dynamic>> updateMobileToken(String loginToken, String mobileToken, int userId)async{
    Map<String, dynamic> response = await _usuarioProvider.actualizarMobileToken(loginToken, mobileToken, userId);
    return response;
  }

  Future<void> cargarUsuario(String pToken)async{
    Map<String, dynamic> response = await _usuarioProvider.getUserByToken(pToken);
    if(response['status'] == 'ok'){
      try{
        usuario = UsuarioModel.fromJsonMap(response['user']);
        String mobileToken = await PushNotificationsProvider.getMobileToken();
        _usuarioProvider.actualizarMobileToken(token, mobileToken, usuario.id);
      }catch(err){
        print('ha ocurrido un error:');
        print(err);
      }     
    }
    return response;
  }

  Future<Map<String, dynamic>> register(String name, String email, String phone, String password, String passwordConfirmation)async{
    Map<String, dynamic> registerResponse = await _usuarioProvider.register(name, email, phone, password, passwordConfirmation);
    
    if(registerResponse['status'] == 'ok'){
      token = registerResponse['token'];
      Map<String, dynamic> userResponse = await _usuarioProvider.getUserByToken(registerResponse['token']);
      usuario = UsuarioModel.fromJsonMap(userResponse['user']);
    }
    return registerResponse;
  }
  
  Future<void> logOut(String token)async{
    Map<String, dynamic> response = await _usuarioProvider.logOut(token);
    if(response['status']=='ok'){
      this.usuario = null;
      this.token = null;
    }

  }

  Future<Map<String, dynamic>> cambiarNombreYAvatar(String token, int userId, String name, File avatar)async{
    Map<String, dynamic> response = await _usuarioProvider.cambiarNombreYAvatar(token, userId, name, avatar);
    return response;
  }

  Future<Map<String, dynamic>> cambiarFoto(String token, File foto)async{
    
  }

  void dispose(){
    _usuarioController.close();
  }
}