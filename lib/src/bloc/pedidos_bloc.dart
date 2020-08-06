import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/models/productos_model.dart';
import 'package:domicilios_cali/src/providers/pedidos_provider.dart';
import 'package:rxdart/rxdart.dart';

class PedidosBloc{
  final estadosPedido = ['inexistente', 'en_carrito', 'por_confirmar'];

  PedidosProvider _pedidosProvider = new PedidosProvider();

  BehaviorSubject<List<Map<String, dynamic>>> _pedidoActualClienteController = BehaviorSubject();
  BehaviorSubject<List<Map<String, dynamic>>> _pedidosHistorialClienteController = BehaviorSubject();
  BehaviorSubject<List<Map<String, dynamic>>> _pedidosHistorialTiendaController = BehaviorSubject();
  BehaviorSubject<List<Map<String, dynamic>>> _pedidosSinRevisarTiendaController = BehaviorSubject();

  Stream<List<Map<String, dynamic>>> get pedidoActualClienteStream => _pedidoActualClienteController.stream;
  Stream<List<Map<String, dynamic>>> get pedidosHistorialClienteStream => _pedidosHistorialClienteController.stream;
  Stream<List<Map<String, dynamic>>> get pedidosHistorialTiendaStream => _pedidosHistorialTiendaController.stream;
  Stream<List<Map<String, dynamic>>> get pedidosSinRevisarTiendaStream => _pedidosSinRevisarTiendaController.stream;

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
    List<Map<String, dynamic>> pedido = (_pedidoActualClienteController.value??[]);
    if(estadoPedido==estadosPedido[0]){
      estadoPedido = estadosPedido[1];
      pedidoActualTiendaId = (ordenProducto['data_product'] as ProductoModel).tiendaId;
    }
    pedido.add(ordenProducto);
    _pedidoActualClienteController.sink.add(pedido);
  }

  void quitarProductoDePedido(Map<String, dynamic> ordenProducto)async{
    if(estadoPedido == estadosPedido[1]){
      List<Map<String, dynamic>> pedido = (await pedidoActualClienteStream.last)??[];
      pedido.remove(ordenProducto);
      _pedidoActualClienteController.sink.add(pedido);
    }
  }
  // ****************************************
  //Comunicación con el back
  // ****************************************

  Future<Map<String, dynamic>> generarPedido(String token, int direccionId)async{
    try{
      List<Map<String, dynamic>> pedidoActual = ( _pedidoActualClienteController.stream.value).cast<Map<String, dynamic>>();
      Map<String, dynamic> crearCarritoResponse = await _pedidosProvider.crearCarritoDeCompras(token, pedidoActual[0]['data_product'].tiendaId, direccionId);   
      if(crearCarritoResponse['status'] == 'ok'){
        List<Map<String, dynamic>> productosCarrito = pedidoActual.map((Map<String, dynamic> producto){
          return {
            'producto_id':producto['data_product'].id,
            'cantidad':producto['cantidad'],
            'precio':producto['precio']
          };
        }).toList();
        Map<String, dynamic> crearProductosCarritoResponse = await _pedidosProvider.crearProductosCarritoDeCompras(token, crearCarritoResponse['pedido']['id'], productosCarrito);    
        if(crearProductosCarritoResponse['status'] != 'ok'){
          print(crearProductosCarritoResponse);
        }
        crearProductosCarritoResponse['tienda_mobile_token'] = crearCarritoResponse['pedido']['tienda_mobile_token'];
        return crearProductosCarritoResponse;
      }else{
        print(crearCarritoResponse);
        return crearCarritoResponse;
      }
    }catch(err){
      print(err);
      return {
        'status':'err',
        'message':err
      };
    }
    
    
  }

  List<Map<String, dynamic>> get valueOfPedidoActualStream{
    return _pedidoActualClienteController.value;
  }

  Future<Map<String, dynamic>> cargarPedidosAnterioresPorClienteOTienda(String token, String tipoUsuario, int tiendaId)async{
    Map<String, dynamic> pedidosResponse = await _pedidosProvider.cargarPedidosAnterioresPorClienteOTienda(token, tipoUsuario, tiendaId);
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
      if(tipoUsuario == 'cliente'){
        _pedidosHistorialClienteController.sink.add(pedidos);
      }else{
        _procesarPedidosTienda(pedidos);
      }
    }
    return pedidosResponse;
  }

  Future<Map<String, dynamic>> updatePedido(String token, Map<String, dynamic> data)async{
    Map<String, dynamic> response = await _pedidosProvider.updatePedido(token, data);
    return response;
  }

  void _procesarPedidosTienda(List<Map<String, dynamic>> pedidos){
    List<Map<String, dynamic>> pedidosSinRevisar = [];
    List<Map<String, dynamic>> pedidosHistorial = [];
    pedidos.forEach((Map<String, dynamic> pedido){
      if(pedido['estado'] == 'generado')
        pedidosSinRevisar.add(pedido);
      else
        pedidosHistorial.add(pedido);
    });
    if(pedidosSinRevisar.length > 0)
      _pedidosSinRevisarTiendaController.sink.add(pedidosSinRevisar);
    if(pedidosHistorial.length > 0)
      _pedidosHistorialTiendaController.sink.add(pedidosHistorial);
  }

  void dispose(){
    _pedidoActualClienteController.close();
    _pedidosHistorialClienteController.close();
    _pedidosSinRevisarTiendaController.close();
  }
}