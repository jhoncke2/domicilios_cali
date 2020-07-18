import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:domicilios_cali/src/models/lugares_model.dart';

class ProductosProvider{
  final _productosServiceRoute = 'https://codecloud.xyz/api/products';
  final _categoriasServiceRoute = 'https://codecloud.xyz/api/categories';
  Future<Map<String, dynamic>> cargarProductosByToken(String token)async{
    final response = await http.get(
      _productosServiceRoute,
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

  Future<Map<String, dynamic>> cargarCategorias(String token)async{
    final response = await http.get(
      _categoriasServiceRoute,
      headers: {
        'Authorization':'Bearer $token'
      }
    );
    try{
      Map<String, dynamic> decodedResponse = json.decode(response.body);
      return{
        'status':'ok',
        'categories':decodedResponse
      };
    }catch(err){

    }
  }
}