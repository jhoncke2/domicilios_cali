import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:domicilios_cali/src/models/tiendas_model.dart';

class TiendaProvider{
  final _serviceRoute = 'https://codecloud.xyz/api/tiendas';

  Future<Map<String, dynamic>> crearTienda(String token, TiendaModel tienda, File ccFrontal, File ccAtras)async{
    Map<String, dynamic> headers = {
      'Authorization':'Bearer $token',
      'Content-Type':'application/x-www-form-urlencoded'
    };
    Map<String, dynamic> body = {
      'cc_atras':ccAtras,
      'cc_frontal':ccFrontal,
      'horario_id':tienda.horarioId,
      'direccion_id':tienda.direccionId,
      'tipo_de_pago':tienda.tipoDePago
    };

    final response = await http.post(
      _serviceRoute,
      headers: headers,
      body: body
    );
    Map<String, dynamic> decodedResponse = json.decode(response.body);
    return decodedResponse;
  }

}