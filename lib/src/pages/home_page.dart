import 'package:domicilios_cali/src/bloc/lugares_bloc.dart';
import 'package:domicilios_cali/src/bloc/productos_bloc.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
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
  BuildContext context;
  Size size;
  String token;
  LugaresBloc lugaresBloc;
  /*
  No entiendo por qué no se quieren subir los cambios
  */
  @override
  Widget build(BuildContext appContext) {
    context = appContext;
    size = MediaQuery.of(context).size;
    token = Provider.usuarioBloc(context).token;
    lugaresBloc = Provider.lugaresBloc(context);

    return Scaffold(
      bottomNavigationBar: BottomBarWidget(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: _crearElementos(),
      ),
    );
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