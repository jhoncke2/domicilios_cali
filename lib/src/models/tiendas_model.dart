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
  String banco;
  String tipoDeCuenta;
  String numeroDeCuenta;
  String certificacionBancariaRoute;
  String ccFrontalRoute;
  String ccAtrasRoute;

  TiendaModel({
    this.id,
    this.userId,
    this.horarioId,
    this.direccionId,
    this.tipoDePago,
    this.banco,
    this.tipoDeCuenta,
    this.numeroDeCuenta,
    this.certificacionBancariaRoute,
    this.ccFrontalRoute,
    this.ccAtrasRoute
  });

  TiendaModel.fromJsonMap(Map<String, dynamic> json){
    id                          = json['id'];
    userId                      = json['user_id'];
    horarioId                   = json['horario_id'];
    direccionId                 = json['direccion_id'];
    tipoDePago                  = json['tipo_de_pago'];
    banco                       = json['banco'];      
    tipoDeCuenta                = json['tipo_de_cuenta'];
    numeroDeCuenta              = json['numero_de_cuenta'];
    certificacionBancariaRoute  = json['certificacion_bancaria'];
    ccFrontalRoute              = json['cc_frontal'];
    ccAtrasRoute                = json['cc_atras'];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> jsonObject = {};
    if(id != null)
      jsonObject['id'] = '$id';
    jsonObject['user_id'] = '$userId';
    jsonObject['horario_id'] = '$horarioId';
    jsonObject['direccion_id'] = '$direccionId';
    jsonObject['tipo_de_pago'] = '$tipoDePago';
    if(banco != null)
      jsonObject['banco']       = banco;
    if(tipoDeCuenta != null)
      jsonObject['tipo_de_cuenta'] = tipoDeCuenta;
    if(numeroDeCuenta != null)
      jsonObject['numero_de_cuenta'] = numeroDeCuenta;
    if(certificacionBancariaRoute != null)
      jsonObject['certificacion_bancaria'] = certificacionBancariaRoute;
    if(ccFrontalRoute != null)
      jsonObject['cc_frontal'] = ccFrontalRoute;
    if(ccAtrasRoute != null)
      jsonObject['cc_atras'] = ccAtrasRoute;
    return jsonObject;
  }
}