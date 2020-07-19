import 'dart:io';

import 'package:rxdart/rxdart.dart';

import 'package:domicilios_cali/src/models/productos_model.dart';
import 'package:domicilios_cali/src/providers/productos_provider.dart';

class ProductosBloc{
  final _productosProvider = new ProductosProvider();
  final _productosTiendaController = new BehaviorSubject<List<ProductoModel>>();
  final _categoriasController = new BehaviorSubject<List<Map<String, dynamic>>>();

  Stream<List<ProductoModel>> get productosTiendaStream => _productosTiendaController.stream;
  Stream<List<Map<String, dynamic>>> get categoriasStream => _categoriasController.stream;

  Future<Map<String, dynamic>> crearProducto(String token, ProductoModel producto, List<File> photos, int categoryId)async{
    Map<String, dynamic> response = await _productosProvider.crearProducto(token, producto, photos, categoryId);
    return response;
  }

  Future<Map<String, dynamic>> cargarProductosTienda(String token)async{
    Map<String, dynamic> response = await _productosProvider.cargarProductosByToken(token);
    if(response['status'] == 'ok'){
      final productosModel = ProductosModel.fromJsonList(response['productos']);
      _productosTiendaController.sink.add(productosModel.productos);
    }
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
    _productosTiendaController.close();
    _categoriasController.close();
  }
 
}