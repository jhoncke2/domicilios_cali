import 'dart:io';

import 'package:domicilios_cali/src/models/lugares_model.dart';
import 'package:domicilios_cali/src/models/usuarios_model.dart';
import 'package:domicilios_cali/src/providers/lugares_provider.dart';
import 'package:domicilios_cali/src/providers/usuario_provider.dart';
import 'package:rxdart/rxdart.dart';

class UsuarioBloc{
  final _lugaresProvider = new LugaresProvider();
  final _usuarioProvider = new UsuarioProvider();

  final _usuarioController = new BehaviorSubject<List<UsuarioModel>>();
  
  UsuarioModel usuario;
  String token;

  Stream<List<UsuarioModel>> get usuarioStream => _usuarioController.stream;

  Future<Map<String, dynamic>> login(String email, String password)async{
    Map<String, dynamic> respuesta = await _usuarioProvider.login(email, password);
    if(respuesta['status']=='ok'){
      Map<String, dynamic> user = await _usuarioProvider.getUserByToken(respuesta['token']);
      usuario = UsuarioModel.fromJsonMap(user);
      token = respuesta['token'];
      return{
        'status':'ok',
        'token':token,
        'user':usuario,
      };
    }
    return respuesta;
  }

  Future<Map<String, dynamic>> register(String name, String email, String phone, String password, String passwordConfirmation)async{
    Map<String, dynamic> respuestaRegister = await _usuarioProvider.register(name, email, phone, password, passwordConfirmation);
    
    if(respuestaRegister['status'] == 'ok'){
      token = respuestaRegister['token'];
      Map<String, dynamic> user = await _usuarioProvider.getUserByToken(respuestaRegister['token']);
      usuario = UsuarioModel.fromJsonMap(user);
      LugarModel tuPosicion = LugarModel(
        nombre: 'Tu ubicación',
        direccion: 'direccion',
        latitud: 0.0,
        longitud: 0.0,
        tipoViaPrincipal: 'tipo_via_principal',
        componentes: [],      
      );
      Map<String, dynamic> respuestaCreateLugar = await _lugaresProvider.crearLugar(tuPosicion, token);
      if(respuestaCreateLugar['status']!='ok')
        //return respuestaCreateLugar;
        print('crear lugar diferente de ok');
    }
    return respuestaRegister;
  }
  
  void logOut(String token)async{
    _usuarioProvider.logOut(token);
  }

  Future<Map<String, dynamic>> cambiarFoto(String token, File foto)async{
    
  }

  void dispose(){
    _usuarioController.close();
  }
}