import 'package:domicilios_cali/src/bloc/lugares_bloc.dart';
import 'package:domicilios_cali/src/bloc/navigation_bloc.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:domicilios_cali/src/widgets/bottom_bar_widget.dart';
import 'package:domicilios_cali/src/widgets/header_widget.dart';
import 'package:domicilios_cali/src/widgets/productos/productos_por_categorias_widget.dart';
import 'package:flutter/material.dart';
//importaciones locales
import 'package:domicilios_cali/src/utils/menu_categorias.dart';

class HomePage extends StatefulWidget with MenuCategorias{
  static final String route = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MenuCategorias{
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String token = Provider.usuarioBloc(context).token;
    LugaresBloc lugaresBloc = Provider.lugaresBloc(context);

    return Scaffold(
      bottomNavigationBar: BottomBarWidget(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal:size.width * 0.05),
        child: _crearElementos(context, lugaresBloc, token),
      ),
    );
  }

  Widget _crearElementos(BuildContext context, LugaresBloc lugaresBloc, String token){
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        //_crearMenuCategorias(size),
        SizedBox(height: size.height * 0.065),
        //_crearHeader(size, lugaresBloc),
        HeaderWidget(),
        ProductosPorCategoriasWidget(),
      ],
    );
  }
}