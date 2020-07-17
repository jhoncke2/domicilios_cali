import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:domicilios_cali/src/models/lugares_model.dart';

class ProductosProvider{
  final _serviceRoute = 'https://codecloud.xyz/api/products';
  Future<Map<String, dynamic>> cargarProductosByToken(String token)async{
    final response = await http.get(
      _serviceRoute,
      headers: {
        'Authorization': 'Bearer $token'
      }
    );
    try{
      final decodedResponse = json.decode(response.body);
      return {
        'status':'ok',
        'productos':decodedResponse['data']
      };
    }catch(err){
      return {
        'status':'err',
        'message':err
      };
    }
  }
}