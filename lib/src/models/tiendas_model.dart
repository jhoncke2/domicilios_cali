import 'dart:core';
//importaciones locales
import 'package:domicilios_cali/src/models/productos_model.dart';

class Tiendas {
  List<Tienda> tiendas = new List();
  /* ***********************************************
   *    Pruebas
   *********************************************** */
  final _tiendasPrueba = [
    {
      'id':1,
      'usuario_id':1,
      'nombre':'Uguay',
      'imagen_url':''
    }
  ];
  Tiendas.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null)
      jsonList = _tiendasPrueba;
    jsonList.forEach((actual){
      final tiendaActual = Tienda.fromJsonMap(actual);
      tiendas.add(tiendaActual);
    });
  }

  List<Tienda> get lugares{
    return tiendas;
  }
}

class Tienda{
  int id;
  int usuarioId;
  String nombre;
  String imagenUrl;
  List<ProductoModel> productos;

  Tienda.fromJsonMap(Map<String, dynamic> json){
    id          = json['id'];
    usuarioId   = json['usuario_id'];
    nombre      = json['nombre'];
    imagenUrl   = json['imagen_url'];
    //aún no verificados.
    productos   = json['productos'];
  }
}