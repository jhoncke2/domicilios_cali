import 'dart:io';

import 'package:domicilios_cali/src/models/horarios_model.dart';
import 'package:domicilios_cali/src/models/lugares_model.dart';
import 'package:domicilios_cali/src/models/tiendas_model.dart';
import 'package:domicilios_cali/src/providers/tienda_provider.dart';
import 'package:rxdart/rxdart.dart';
class TiendaBloc{
  final _tiendaProvider = new TiendaProvider();
  final _tiendaController = new BehaviorSubject<TiendaModel>();

  Stream<TiendaModel> get tiendaStream => _tiendaController.stream;

  TiendaModel tienda;
  LugarModel direccionTienda;
  HorarioModel horarioTienda;

  //creación de tienda
  bool enCreacion = false;
  File ccAtras;
  File ccDelantera;
  File certificacionBancaria;

  Future<Map<String, dynamic>> crearTienda(String token)async{
    Map<String, dynamic> response = await _tiendaProvider.crearTienda(token, tienda, ccDelantera, ccAtras, certificacionBancaria);
    return response;
  }

  Future<Map<String, dynamic>> cargarTienda(String token)async{
    Map<String, dynamic> response = await _tiendaProvider.cargarTienda(token);
    
    if(response['status'] == 'ok'){
      tienda = TiendaModel();
      if(response['tienda'] != null)
        tienda = TiendaModel.fromJsonMap( response['tienda']);
      _tiendaController.sink.add(tienda);
    }else{
      _tiendaController.sink.add(TiendaModel());
    }
    return response;
  }

  Future<Map<String, dynamic>> crearHorario(String token){
    Future<Map<String, dynamic>> response = _tiendaProvider.crearHorario(token, horarioTienda);
    return response;
  }

  void iniciarCreacionTienda(){
    enCreacion = true;
    tienda = TiendaModel();
    horarioTienda = HorarioModel();
  }

  void dispose(){
    _tiendaController.close();
  }
}