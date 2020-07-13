import 'dart:core';

class TiendasModel {
  List<TiendaModel> tiendas = new List();
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
  TiendasModel.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null)
      jsonList = _tiendasPrueba;
    jsonList.forEach((actual){
      final tiendaActual = TiendaModel.fromJsonMap(actual);
      tiendas.add(tiendaActual);
    });
  }

  List<TiendaModel> get lugares{
    return tiendas;
  }
}

class TiendaModel{
  int id;
  int userId;
  int horarioId;
  int direccionId;
  String tipoDePago;
  String ccFrontalRoute;
  String ccAtrasRoute;


  TiendaModel.fromJsonMap(Map<String, dynamic> json){
    id                = json['id'];
    userId            = json['user_id'];
    horarioId         = json['horario_id'];
    direccionId       = json['direccion_id'];
    tipoDePago        = json['tipo_de_pago'];
    ccFrontalRoute    = json['cc_frontal'];
    ccAtrasRoute      = json['cc_atras'];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> jsonObject = {};
    if(id != null)
      jsonObject['id'] = '$id';
    jsonObject['user_id'] = '$userId';
    jsonObject['horario_id'] = '$horarioId';
    jsonObject['direccion_id'] = '$direccionId';
    jsonObject['tipo_de_pago'] = '$tipoDePago';
    if(ccFrontalRoute != null)
      jsonObject['cc_frontal'] = ccFrontalRoute;
    if(ccAtrasRoute != null)
      jsonObject['cc_atras'] = ccAtrasRoute;
    return jsonObject;
  }
}