import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:domicilios_cali/src/models/lugares_model.dart';
import 'package:domicilios_cali/src/utils/data_prueba/lugares_prueba.dart';

class LugaresProvider with LugaresPrueba{
  final _serviceRoute = 'https://codecloud.xyz/api/direcciones';
  final _serviceDireccionRoute = 'https://codecloud.xyz/api/direccion';
  List<LugarModel> _lugares;

  Future<List<dynamic>> cargarLugares(String token)async{
    //a modo de prueba, mientras se implementa el crud
    final response = await http.get(
      _serviceRoute,
      headers: {
        'Authorization':'Bearer $token'
      }
    );
    print(response);
    Map<String, dynamic> decodedResponse = json.decode(response.body);
    return decodedResponse['direcciones'];
  }

  Future<List<LugarModel>> cargarLugaresByUserId(int id)async{
    if(_lugares == null)
      _lugares = LugaresModel.fromJsonList(super.lugares).lugares;
    return _lugares;
  }

  Future<Map<String, dynamic>> crearLugar(LugarModel lugar, String token)async{
    print(lugar);
    try{
      final response = await http.post(
        _serviceRoute,
        body: lugar.toJson(),
        headers: {
          'Authorization':'Bearer $token',
          //'Content-Type':'application/json'
        }
      );
      print(response);
      Map<String, dynamic> decodedResponse = json.decode(response.body);
      if(decodedResponse['status']==null){
        return {
          'status':'ok',
          'content':decodedResponse['direccion']
        };
      }
      return decodedResponse;
    }catch(err){
      return {
        'status':'err',
        'message':err
      };
    }
    
  }

  Future<void> elegirLugar(int idLugar, String token)async{
    final elegirRoute = '$_serviceDireccionRoute/elegido/$idLugar';
    final response = await http.get(
      elegirRoute,
      headers: {
        'Authorization':'Bearer $token'
      }
    );
    print('**********************');
    print('desde elegir lugar response: ');
    print(response.toString());
    Map<String, dynamic> decodedResponse = json.decode(response.body);
    print('***********************');
    print('elegir lugar decodedResponse: ');
    print(decodedResponse.toString());
  }

  Future<Map<String, dynamic>> latLong(int idLugar, String token, double latitud, double longitud)async{
    final latlonRoute = '$_serviceDireccionRoute/latlon/$idLugar';
    final response = await http.post(
      latlonRoute,
      headers: {
        'Authorization':'Bearer $token'
      },
      body: {
        'latitud': '$latitud',
        'longitud': '$longitud'
      }
    );

    final decodedData = json.decode(response.body);
    return decodedData;
  }
  
  Future<Map<String, dynamic>> editarLugar(LugarModel lugar, String token)async{
    //a modo de prueba, mientras se implementa el crud}
    
    final response = await http.put(
      '$_serviceRoute/${lugar.id}',
      body: lugar.toJson(),
      headers: {
        'Authorization':'Bearer $token'
      }
    );

    final decodedResponse = json.decode(response.body);
    return decodedResponse;
  }

  Future<void> eliminarLugar(int idLugar)async{
    _lugares.remove(_lugares.singleWhere((element) => element.id == idLugar));
  }
}