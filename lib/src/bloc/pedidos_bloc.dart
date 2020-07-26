import 'package:domicilios_cali/src/models/productos_model.dart';
import 'package:domicilios_cali/src/providers/pedidos_provider.dart';
import 'package:rxdart/rxdart.dart';

class PedidosBloc{
  final estadosPedido = ['inexistente', 'en_carrito', 'por_confirmar'];

  PedidosProvider _pedidosProvider = new PedidosProvider();

  BehaviorSubject<List<Map<String, dynamic>>> _pedidoActualController = BehaviorSubject();
  BehaviorSubject<List<Map<String, dynamic>>> _pedidosAnterioresController = BehaviorSubject();

  Stream<List<Map<String, dynamic>>> get pedidoActualStream => _pedidoActualController.stream;
  Stream<List<Map<String, dynamic>>> get pedidosAnterioresStream => _pedidosAnterioresController.stream;

  String estadoPedido;
  int pedidoActualTiendaId;
  double valorTotalPedidoActual;
  /**
   * 0: pedido actual
   * 1: pedidos anteriores
   */
  int indexNavegacionPedidosPage = 0;


  PedidosBloc(){
    //falta por implementar la caché
    estadoPedido = estadosPedido[0];
    indexNavegacionPedidosPage = (estadoPedido==estadosPedido[1])? 0 : 1;
  }

  Future<void> agregarProductoAPedido(Map<String, dynamic> ordenProducto)async{
    List<Map<String, dynamic>> pedido = (_pedidoActualController.value??[]);
    if(estadoPedido==estadosPedido[0]){
      estadoPedido = estadosPedido[1];
      pedidoActualTiendaId = (ordenProducto['data_product'] as ProductoModel).store.id;
    }
    pedido.add(ordenProducto);
    _pedidoActualController.sink.add(pedido);
  }

  void quitarProductoDePedido(Map<String, dynamic> ordenProducto)async{
    if(estadoPedido == estadosPedido[1]){
      List<Map<String, dynamic>> pedido = (await pedidoActualStream.last)??[];
      pedido.remove(ordenProducto);
      _pedidoActualController.sink.add(pedido);
    }
  }
  // ****************************************
  //Comunicación con el back
  // ****************************************

  Future<Map<String, dynamic>> generarPedido(String token, int clienteId, List<Map<String, dynamic>> productsMap)async{
    Map<String, dynamic> crearCarritoResponse = await _pedidosProvider.crearCarritoDeCompras(token, clienteId);
    if(crearCarritoResponse['status'] == 'ok'){
      Map<String, dynamic> crearProductosCarritoResponse = await _pedidosProvider.crearProductosCarritoDeCompras(token, crearCarritoResponse['pedido']['id'], productsMap);
      if(crearProductosCarritoResponse['status'] != 'ok'){
        print(crearProductosCarritoResponse);
      }
      return crearProductosCarritoResponse;
    }else{
      print(crearCarritoResponse);
      return crearCarritoResponse;
    }
  }

  Future<Map<String, dynamic>> cargarPedidosAnteriores(String token)async{
    Map<String, dynamic> pedidosResponse = await _pedidosProvider.cargarPedidosAnteriores(token);
    if(pedidosResponse['status'] == 'ok'){
      List<Map<String, dynamic>> pedidos = ((pedidosResponse['pedidos'] as List).cast<Map<String, dynamic>>()).map((Map<String, dynamic> pedido){
        Map<String, dynamic> pedidoFormateado = pedido;
        List<Map<String, dynamic>> products = ((pedido['products'] as List).cast<Map<String, dynamic>>()).map((Map<String, dynamic> product){
          
          return {
            'product_id':product['product_id'],
            'cantidad':product['cantidad'],
            'precio':product['precio'],
            'data_product':ProductoModel.fromJsonMap(product['data_product'])
          };
        }).toList();
        pedidoFormateado['products'] = products;
        return pedidoFormateado;
      }).toList();
      _pedidosAnterioresController.sink.add(pedidos);
    }
    return pedidosResponse;
  }

  void dispose(){
    _pedidoActualController.close();
    _pedidosAnterioresController.close();
  }
}