import 'dart:io';

import 'package:domicilios_cali/src/models/productos_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductosProvider{

  final _productosPublicServiceRoute = 'https://codecloud.xyz/api/products/public';
  final _productosServiceRoute = 'https://codecloud.xyz/api/products';
  final _productosFavoritosRoute = 'https://codecloud.xyz/api/user-products/favorite';
  final _categoriasServiceRoute = 'https://codecloud.xyz/api/category/public';

  Future<Map<String, dynamic>> cargarProductosPublic()async{
    final response = await http.get(
      _productosPublicServiceRoute
    );
    try{
      Map<String, dynamic> decodedResponse = json.decode(response.body);
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

  Future<Map<String, dynamic>> crearProducto(String token, ProductoModel producto, List<File> photos, int categoryId)async{
    Map<String, String> headers = {
      'Authorization':'Bearer $token',
      'Content-Type':'application/x-www-form-urlencoded'
    };
    
    Map<String, String> fields = producto.toJson();
    fields['category_id'] = categoryId.toString();
    var request = await http.MultipartRequest(
      'POST', 
      Uri.parse(_productosServiceRoute)
    );
    request.headers.addAll(headers);
    request.fields.addAll(fields);
    request.files.addAll(photos.map((File photo){
      return http.MultipartFile(
        'imagenes[]',
        photo.readAsBytes().asStream(),
        photo.lengthSync(),
        filename: photo.path.split('/').last
      );
    }));

    final streamResponse = await request.send();
    final response = await http.Response.fromStream(streamResponse);
    try{
      Map<String, dynamic> decodedResponse = json.decode(response.body);
      return {
        'status':'ok',
        'data':decodedResponse
      };
    }catch(err){
      return {
        'status':'err',
        'message':err
      };
    }

  }

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

  Future<Map<String, dynamic>> cargarFavoritos(String token)async{
    final response = await http.get(
      _productosFavoritosRoute,
      headers: {
        'Authorization':'Bearer $token'
      }
    );

    try{
      Map<String, dynamic> decodedResponse = json.decode(response.body);
      return {
        'status':'ok',
        'favoritos':decodedResponse['data']
      };
    }catch(err){
      return {
        'status':'err',
        'message':err
      };
    }
  }

  Future<Map<String, dynamic>> crearFavorito(String token, int clienteId, int productoId)async{
    final response = await http.post(
      _productosFavoritosRoute,
      headers:{
        'Authorization':'Bearer $token'
      },
      body: {
        'cliente_id':clienteId.toString(),
        'producto_id':productoId.toString()
      }
    );

    try{
      final decodedResponse = json.decode(response.body);
      return {
        'status':'ok',
        'data':decodedResponse
      };
    }catch(err){
      return {
        'status':'err',
        'message':err
      };
    }
  }

  Future<Map<String, dynamic>> eliminarFavorito(String token, int favoritoId)async{
    final response = await http.delete(
      '$_productosFavoritosRoute/$favoritoId',
      headers:{
        'Authorization':'Bearer $token'
      }
    );

    try{
      final decodedResponse = json.decode(response.body);
      if(decodedResponse == "true" || decodedResponse == true){
        return {
          'status':'ok'
        };
      }else{
        return {
          'status':'err',
          'message':decodedResponse
        };
      }
    }catch(err){
      return {
        'status':'err',
        'message':err
      };
    }
  }

  Future<Map<String, dynamic>> cargarCategorias()async{
    final response = await http.get(
      _categoriasServiceRoute,
    ); 
    try{
      List<Map<String, dynamic>> decodedResponse = (json.decode(response.body) as List).cast<Map<String, dynamic>>();
      return{
        'status':'ok', 
        'categorias':decodedResponse
      };
    }catch(err){
      return {
        'status':'err',
        'message':err
      };
    }
  }
}