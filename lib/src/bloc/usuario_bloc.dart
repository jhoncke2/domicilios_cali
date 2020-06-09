import 'dart:io';

import 'package:domicilios_cali/src/models/lugares_model.dart';
import 'package:domicilios_cali/src/models/usuarios_model.dart';
import 'package:domicilios_cali/src/providers/lugares_provider.dart';
import 'package:domicilios_cali/src/providers/usuario_provider.dart';
import 'package:rxdart/rxdart.dart';

class UsuarioBloc{
  final _usuarioProvider = new UsuarioProvider();
  final _usuarioController = new BehaviorSubject<List<Usuario>>();

  final _lugaresProvider = new LugaresProvider();

  Usuario usuario;
  String token;

  Stream<List<Usuario>> get lugaresStream => _usuarioController.stream;

  Future<Map<String, dynamic>> login(String email, String password)async{
    Map<String, dynamic> respuesta = await _usuarioProvider.login(email, password);
    if(respuesta['status']=='ok'){
      Map<String, dynamic> user = await _usuarioProvider.getUserByToken(respuesta['token']);
      usuario = Usuario.fromJsonMap(user['user']);
      token = respuesta['token'];
      return{
        'status':'ok',
        'token':token,
        'user':usuario,
      };
    }
    return respuesta;
  }

  Future<Map<String, dynamic>> register(String name, String email, String password)async{
    Map<String, dynamic> respuestaRegister = await _usuarioProvider.register(name, email, password);
    if(respuestaRegister['status'] == 'ok'){
      token = respuestaRegister['token'];
      print('*****************************');
      print('desde usuario Bloc-register');
      print(respuestaRegister);
      print(token);
      LugarModel tuPosicion = LugarModel(
        nombre: 'Tu ubicación',
        direccion: 'direccion',
        latitud: 0.0,
        longitud: 0.0,
        tipoViaPrincipal: 'tipo_via_principal',
        componentes: [],
      );

      Map<String, dynamic> respuestaCreateLugar = await _lugaresProvider.crearLugar(tuPosicion, token);
      print('*****************************');
      print('desde usuario bloc-createLugar:');
      print(respuestaCreateLugar);
    }
    
    return respuestaRegister;
  }

  Future<Map<String, dynamic>> cambiarFoto(String token, File foto)async{
    
  }
}