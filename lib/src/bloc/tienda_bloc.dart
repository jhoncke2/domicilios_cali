import 'package:domicilios_cali/src/models/lugares_model.dart';
import 'package:rxdart/rxdart.dart';
class TiendaBloc{
  final _crearTiendaController = new BehaviorSubject<int>();
  final _lugarCreadoController = new BehaviorSubject<LugarModel>();

  Stream<int> get crearTiendaStream => _crearTiendaController.stream;
  Stream<LugarModel> get lugarCreadoStream => _lugarCreadoController.stream;

  void siguientePaso(int pasoActual){
    _crearTiendaController.sink.add(pasoActual);
  }

  void agregarLugarCreado(LugarModel lugar){
    _lugarCreadoController.add(lugar);
  }
}