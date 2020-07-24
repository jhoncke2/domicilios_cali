import 'dart:io';

import 'package:rxdart/rxdart.dart';

import 'package:domicilios_cali/src/models/productos_model.dart';
import 'package:domicilios_cali/src/providers/productos_provider.dart';

class ProductosBloc{
  final _productosProvider = new ProductosProvider();

  final _productosPublicController = new BehaviorSubject<List<ProductoModel>>();
  final _productosTiendaController = new BehaviorSubject<List<ProductoModel>>();
  final _favoritosStream = new BehaviorSubject<List<Map<String, dynamic>>>();
  final _categoriasController = new BehaviorSubject<List<Map<String, dynamic>>>();
  

  Stream<List<ProductoModel>> get productosPublicStream => _productosPublicController.stream;
  Stream<List<ProductoModel>> get productosTiendaStream => _productosTiendaController.stream;
  Stream<List<Map<String, dynamic>>> get favoritosStream => _favoritosStream.stream;
  Stream<List<Map<String, dynamic>>> get categoriasStream => _categoriasController.stream;

  Future<Map<String, dynamic>> crearProducto(String  token, ProductoModel producto, List<File> photos, int categoryId)async{
    Map<String, dynamic> response = await _productosProvider.crearProducto(token, producto, photos, categoryId);
    return response;
  }

  Future<Map<String, dynamic>> cargarProductosTienda(int tiendaId)async{
    Map<String, dynamic> response = await _productosProvider.cargarProductosTienda(tiendaId);
    if(response['status'] == 'ok'){
      final productosModel = ProductosModel.fromJsonList(response['productos']);
      _productosTiendaController.sink.add(productosModel.productos);
    }
    return response;
  }

  Future<Map<String, dynamic>> cargarProductosPublic()async{
    Map<String, dynamic> response = await _productosProvider.cargarProductosPublic();
    if(response['status'] == 'ok')
      response['productos'] = ProductosModel.fromJsonList(response['productos']).productos;
      _productosPublicController.sink.add(
        response['productos']
      );
    return response;
  }

  Future<Map<String, dynamic>> cargarFavoritos(String token)async{
    Map<String, dynamic> response = await _productosProvider.cargarFavoritos(token);
    if(response['status'] == 'ok')
      _favoritosStream.sink.add((response['favoritos'] as List).cast<Map<String, dynamic>>());
    return response;
  }

  Future<Map<String, dynamic>> crearFavorito(String token, int clienteId, int productoId)async{
    Map<String, dynamic> response = await _productosProvider.crearFavorito(token, clienteId, productoId);
    if(response['status'] == 'ok')
      cargarFavoritos(token);
    return response;
  }

  Future<Map<String, dynamic>> eliminarFavorito(String token, int favoritoId)async{
    Map<String, dynamic> response = await _productosProvider.eliminarFavorito(token, favoritoId);
    if(response['status'] == 'ok')
      cargarFavoritos(token);
    return response;
  }

  Future<Map<String, dynamic>> cargarCategorias()async{
    Map<String, dynamic> response = await _productosProvider.cargarCategorias();
    if(response['status'] == 'ok'){
      _categoriasController.sink.add(response['categorias']);
    }
    return response;
  }

  void dispose(){
    _productosPublicController.close();
    _productosTiendaController.close();
    _favoritosStream.close();
    _categoriasController.close();
  }
 
}