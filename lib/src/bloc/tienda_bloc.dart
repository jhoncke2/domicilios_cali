import 'dart:io';

import 'package:domicilios_cali/src/models/lugares_model.dart';
import 'package:domicilios_cali/src/models/tiendas_model.dart';
import 'package:domicilios_cali/src/providers/tienda_provider.dart';
import 'package:rxdart/rxdart.dart';
class TiendaBloc{
  final _tiendaProvider = new TiendaProvider();

  final _crearTiendaController = new BehaviorSubject<int>();
  final _lugarCreadoController = new BehaviorSubject<LugarModel>();

  Stream<int> get crearTiendaStream => _crearTiendaController.stream;
  Stream<LugarModel> get lugarCreadoStream => _lugarCreadoController.stream;

  void siguientePaso(int pasoActual){
    _crearTiendaController.sink.add(pasoActual);
  }

  void agregarLugarCreado(LugarModel lugar){
    _lugarCreadoController.add(lugar);
  }

  Future<Map<String, dynamic>> crearTienda(String token, TiendaModel tienda, File ccFrontal, File ccAtras)async{
    Map<String, dynamic> decodedResponse = await _tiendaProvider.crearTienda(token, tienda, ccFrontal, ccAtras);
  }

  void dispose(){
    _crearTiendaController.close();
    _lugarCreadoController.close();
  }
}