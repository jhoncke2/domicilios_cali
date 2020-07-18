import 'package:domicilios_cali/src/bloc/confirmation_bloc.dart';
import 'package:domicilios_cali/src/bloc/lugares_bloc.dart';
import 'package:domicilios_cali/src/bloc/navigation_bloc.dart';
import 'package:domicilios_cali/src/bloc/productos_bloc.dart';
import 'package:domicilios_cali/src/bloc/tienda_bloc.dart';
import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:flutter/cupertino.dart';

class Provider extends InheritedWidget{
  final _lugaresBloc = new LugaresBloc();
  final _usuarioBloc = new UsuarioBloc();
  final _tiendaBloc = new TiendaBloc();
  final _navigationBloc = new NavigationBloc();
  final _confirmationBloc = new ConfirmationBloc();
  final _productosBloc = new ProductosBloc();

  static Provider _instancia;

  factory Provider({Key key, Widget child}){
    if(_instancia == null){
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;
  }

  Provider._internal({Key key, Widget child})
    :super(key: key, child: child);

  /**
   * ¿Al actualizarse debe notificarle a los hijos?: true
   */
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LugaresBloc lugaresBloc(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._lugaresBloc;
  }

  static UsuarioBloc usuarioBloc(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._usuarioBloc;
  }

  static TiendaBloc tiendaBloc(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._tiendaBloc;
  }

  static NavigationBloc navigationBloc(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._navigationBloc;
  }

  static ConfirmationBloc confirmationBloc(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._confirmationBloc;
  }

  static ProductosBloc productosBloc(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._productosBloc;
  }

  void dispose(){
    _lugaresBloc.dispose();
    _usuarioBloc.dispose();
    _confirmationBloc.dispose();
    _productosBloc.dispose();
  }
}