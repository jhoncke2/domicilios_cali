import 'package:domicilios_cali/src/models/productos_model.dart';
import 'package:rxdart/rxdart.dart';

class PedidosBloc{
  BehaviorSubject<List<Map<String, dynamic>>> _pedidoActualController = BehaviorSubject();
  Stream<List<Map<String, dynamic>>> get pedidoActualStream => _pedidoActualController.stream;

  void agregarProductosAPedido(Map<String, dynamic> productos)async{
    List<Map<String, dynamic>> pedido = (await pedidoActualStream.last)??[];
    
    
    print(pedido);
    pedido.add(productos);
    _pedidoActualController.sink.add(pedido);
  }

  void dispose(){
    _pedidoActualController.close();
  }
}