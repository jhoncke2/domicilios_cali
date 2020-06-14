import 'package:flutter/material.dart';
import 'dart:convert';

class HorariosModel {
  List<HorarioModel> lugares = new List();

  /* ***********************************************
   *    Pruebas
   *********************************************** */

   /* ***********************************************
   *    fin datos prueba
   *********************************************** */
   
  HorariosModel.fromJsonList(List<dynamic> jsonList){
    if(jsonList==null)
      return;
    jsonList.forEach((element) {
      final lugarActual = HorarioModel.fromJsonMap(element);
      lugares.add(lugarActual);
    });
  }

  List<HorarioModel> getLugares(){
    return lugares;
  }

}

class HorarioModel{
  int id;
  TimeOfDay horaInicial;
  TimeOfDay horaFinal;
  List<String> dias;

  HorarioModel({
    this.id,
    this.horaInicial,
    this.horaFinal,
    this.dias,
  });

  HorarioModel.fromJsonMap(Map<String, dynamic> jsonObject){
    id = jsonObject['id'];
    horaInicial = TimeOfDay(
      hour: int.parse(jsonObject['hora_inicial']),
      minute: int.parse(jsonObject['minuto_inicial']),
    );
    horaFinal = TimeOfDay(
      hour: int.parse(jsonObject['hora_final']),
      minute: int.parse(jsonObject['minuto_final']),
    );

    dias = json.decode(jsonObject['dias']);
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> jsonObject = {};
    
    if(id != null)
      jsonObject['id'] = '$id';
    jsonObject['hora_inicial'] = '${horaInicial.hour}:${horaInicial.minute}';
    jsonObject['hora_final'] = '${horaFinal.hour}:${horaFinal.minute}';
    jsonObject['dias'] = json.encode(dias);
    return jsonObject;
  }

}
