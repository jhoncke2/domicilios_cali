import 'package:http/http.dart' as http;
import 'dart:convert';
class PedidosProvider{
  final _apiUrl = 'https://codecloud.xyz/api';

  Future<Map<String, dynamic>> crearCarritoDeCompras(String token, int clienteId)async{
    try{
      final response = await http.post(
        '$_apiUrl/shoppingcart',
        headers: {
          'Authorization':'Bearer $token'
        },
        body: {
          'cliente_id':clienteId
        }
      );
      Map<String, dynamic> decodedResponse = json.decode(response.body);
      return {
        'status':'ok',
        'pedido': decodedResponse
      };
    }catch(err){
      return {
        'status':'err',
        'message':err
      };
    }
  }

  Future<Map<String, dynamic>> crearProductosCarritoDeCompras(String token, int shoppingCartId, List<Map<String, dynamic>> productsMap)async{
    try{
      final response = await http.post(
        '$_apiUrl/shoppingcart-products',
        headers: {
          'Authorization':'Bearer $token'
        },
        body: {
          'shopping_cart_id':shoppingCartId,
          'products':productsMap
        }
      );
      Map<String, dynamic> decodedResponse = json.decode(response.body);
      return {
        'status':'ok',
        'pedido':decodedResponse
      };
    }catch(err){
      return {
        'status':'err',
        'message':err
      };
    }
  }

  Future<Map<String, dynamic>> cargarPedidosAnteriores(String token)async{
    try{
      final response = await http.get(
        '$_apiUrl/shoppingcart',
        headers: {
          'Authorization':'Bearer $token'
        }
      );
      Map<String, dynamic> decodedResponse = json.decode(response.body);
      return {
        'status':'ok',
        'pedidos': decodedResponse['data']
      };
    }catch(err){
      return {
        'status':'err',
        'message':err
      };
    }
  }
}