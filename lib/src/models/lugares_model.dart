import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';

class LugaresModel {
  List<LugarModel> lugares = new List();

  /* ***********************************************
   *    Pruebas
   *********************************************** */

   /* ***********************************************
   *    fin datos prueba
   *********************************************** */
   
  LugaresModel.fromJsonList(List<dynamic> jsonList){
    if(jsonList==null)
      return;
    jsonList.forEach((element) {
      final lugarActual = LugarModel.fromJsonMap(element);
      lugares.add(lugarActual);
    });
  }

  List<LugarModel> getLugares(){
    return lugares;
  }

}

class LugarModel{
  int id;
  String nombre;
  String direccion;
  double latitud;
  double longitud;
  bool elegido;
  String tipoViaPrincipal;
  List<Map<String, dynamic> > componentes = []; 

  LugarModel({
    this.id,
    this.nombre,
    this.direccion,
    this.latitud,
    this.longitud,
    this.elegido,
    this.tipoViaPrincipal,
    this.componentes,
  });

  LugarModel.fromJsonMap(Map<String, dynamic> jsonObject){
    id                            = jsonObject['id'];
    nombre                        = jsonObject['nombre'];
    direccion                     = jsonObject['direccion'];
    latitud                       = double.parse( jsonObject['latitud'] );
    longitud                      = double.parse( jsonObject['longitud'] );
    elegido                       = (jsonObject['elegido'] == 1 )? true : false ;
    tipoViaPrincipal              = jsonObject['tipo_via_principal'];

    json.decode(jsonObject['componentes']).forEach((element){
      componentes.add({
        'nombre':element['nombre'],
        'valor':element['valor'],
      });
    });
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> jsonObject = {};
    jsonObject['nombre'] = nombre;
    jsonObject['direccion'] = direccion;
    
    jsonObject['componentes'] = (componentes != null)? json.encode(componentes):json.encode([]);
    if(id != null)
    jsonObject['id'] = '$id';
    jsonObject['latitud'] = '$latitud';
    jsonObject['longitud'] = '$longitud';
    if(elegido != null)
      jsonObject['elegido'] = '$elegido';
    jsonObject['tipo_via_principal'] = tipoViaPrincipal;
    return jsonObject;
  }

  LatLng get latLng{
    return LatLng(latitud, longitud);
  }

  @override
  String toString(){
    String respuesta = '';
    respuesta += '{id:$id\nnombre:$nombre\ndireccion:$direccion\nlatitud:$latitud\nlongitud:$longitud\nelegido:$elegido\ntipoViaPrincipal$tipoViaPrincipal\n';
    respuesta += 'componentes:[\n';
    if(componentes != null){
      componentes.forEach((element) {
        respuesta += '{nombre:${element["nombre"]}\nvalor:${element["valor"]}\n';
      });
      respuesta +=']\n';
    }
    respuesta += '}';
    
    return respuesta;
  }
}
