import 'package:domicilios_cali/src/bloc/lugares_bloc.dart';
import 'package:domicilios_cali/src/bloc/productos_bloc.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:domicilios_cali/src/widgets/bottom_bar_widget.dart';
import 'package:domicilios_cali/src/widgets/categorias_scrollview_widget.dart';
import 'package:domicilios_cali/src/widgets/header_widget.dart';
import 'package:domicilios_cali/src/widgets/productos/productos_widget.dart';
import 'package:flutter/material.dart';
//importaciones locales
import 'package:domicilios_cali/src/utils/menu_categorias.dart';

class HomePage extends StatefulWidget with MenuCategorias{
  static final String route = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MenuCategorias{
  bool recienIniciada = true;
  BuildContext context;
  Size size;
  String token;
  UsuarioBloc usuarioBloc;
  LugaresBloc lugaresBloc;
  ProductosBloc productosBloc;

  /*
  No entiendo por qué no se quieren subir los cambios
  */
  @override
  Widget build(BuildContext appContext) {
    print('codigo icono:');
    print(Icons.fastfood.codePoint);
    context = appContext;
    if(!Provider.pushNotificationsProvider(context).yaInicio)
      Provider.pushNotificationsProvider(context).initNotificationsReceiver();
    Provider.pushNotificationsProvider(context).context = appContext;
    
    size = MediaQuery.of(context).size;
    token = Provider.usuarioBloc(context).token;
    usuarioBloc = Provider.usuarioBloc(context);
    lugaresBloc = Provider.lugaresBloc(context);
    productosBloc = Provider.productosBloc(context);
    if(usuarioBloc.usuario != null)
      productosBloc.cargarFavoritos(token);

    return Scaffold(
      bottomNavigationBar: BottomBarWidget(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: _crearElementos(),
      ),
    );
  }

  void inicializarPushNotificationsProvider()async{

  }

  Widget _crearElementos(){
    return Column(
      children: <Widget>[
        //_crearMenuCategorias(size),
        SizedBox(height: size.height * 0.065),
        //_crearHeader(size, lugaresBloc),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: HeaderWidget()
        ),
        SizedBox(
          height: size.height * 0.005,
        ),
        CategoriasScrollviewWidget(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          //child: ProductosPorCategoriasWidget(),
          child: ProductosWidget(
            heightPercent: 0.6,
          ),
        ),      
      ],
    );
  }
}