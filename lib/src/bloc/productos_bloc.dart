import 'package:rxdart/rxdart.dart';

import 'package:domicilios_cali/src/models/productos_model.dart';
import 'package:domicilios_cali/src/providers/productos_provider.dart';

class ProductosBloc{
  final _productosProvider = new ProductosProvider();
  final _productosTiendaController = new BehaviorSubject<List<ProductoModel>>();
  final _categoriasController = new BehaviorSubject<List<Map<String, dynamic>>>();

  Stream<List<ProductoModel>> get productosTiendaStream => _productosTiendaController.stream;
  Stream<List<Map<String, dynamic>>> get categoriasStream => _categoriasController.stream;

  Future<Map<String, dynamic>> cargarProductosTienda(String token)async{
    Map<String, dynamic> response = await _productosProvider.cargarProductosByToken(token);
    if(response['status'] == 'ok'){
      final productosModel = ProductosModel.fromJsonList(response['productos']);
      _productosTiendaController.sink.add(productosModel.productos);
    }
    return response;
  }

  Future<Map<String, dynamic>> cargarCategorias(String token)async{
    Map<String, dynamic> response = await _productosProvider.cargarCategorias(token);
    if(response['status'] == 'ok'){

    }
  }

  void dispose(){
    _productosTiendaController.close();
    _categoriasController.close();
  }
 
}