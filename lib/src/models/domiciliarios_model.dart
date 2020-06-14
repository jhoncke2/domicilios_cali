import 'dart:io';
class DomiciliariosModel {
  List<DomiciliarioModel> _domiciliarios = new List();

  /* ***********************************************
   *    Pruebas
   *********************************************** */

   /* ***********************************************
   *    fin datos prueba
   *********************************************** */
   
  DomiciliariosModel.fromJsonList(List<dynamic> jsonList){
    if(jsonList==null)
      return;
    jsonList.forEach((element) {
      final domiciliarioActual = DomiciliarioModel.fromJsonMap(element);
      _domiciliarios.add(domiciliarioActual);
    });
  }

  List<DomiciliarioModel> get domiciliarios{
    return _domiciliarios;
  }

}

class DomiciliarioModel{
  int id;
  String nombre;
  String email;
  String numeroCelular;
  String tipoVehiculo;
  String placaVehiculo;
  File foto;
  File cedulaCara1;
  File cedulaCara2;
  String cedulaCaraUrl1;
  String cedulaCaraUrl2;
  String fotoUrl;

  DomiciliarioModel({
    this.id,
    this.nombre,
    this.email,
    this.numeroCelular,
    this.tipoVehiculo,
    this.placaVehiculo,
    this.cedulaCara1,
    this.cedulaCara2,
    this.foto
  });

  DomiciliarioModel.fromJsonMap(Map<String, dynamic> jsonObject){
    id = jsonObject['id'];
    nombre = jsonObject['nombre'];
    email = jsonObject['email'];
    numeroCelular = jsonObject['numero_celular'];
    tipoVehiculo = jsonObject['tipo_vehiculo'];
    placaVehiculo = jsonObject['placa_vehiculo'];
    fotoUrl = jsonObject['foto_url'];
    cedulaCaraUrl1 = jsonObject['cedula_cara_url_1'];
    cedulaCaraUrl2 = jsonObject['cedula_cara_url_2'];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> jsonObject = {};
    
    if(id!=null)
      jsonObject['id'] = id;
    jsonObject['nombre'] = nombre;
    jsonObject['email'] = email;
    jsonObject['numero_celular'] = numeroCelular;
    jsonObject['tipo_vehiculo'] = tipoVehiculo;
    jsonObject['placa_vehiculo'] = placaVehiculo;
    jsonObject['foto_url'] = fotoUrl;
    jsonObject['cedula_cara_url_1'] = cedulaCaraUrl1;
    jsonObject['cedula_cara_url_2'] = cedulaCaraUrl2;
    return jsonObject;
  }

}
