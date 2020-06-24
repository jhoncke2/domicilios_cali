import 'package:domicilios_cali/src/widgets/bottom_bar_widget.dart';
import 'package:domicilios_cali/src/widgets/header_widget.dart';
import 'package:domicilios_cali/src/widgets/productos/productos_por_categorias_widget.dart';
import 'package:flutter/material.dart';
class CuentaPage extends StatefulWidget {
  static final route = 'cuenta';
  @override
  _CuentaPageState createState() => _CuentaPageState();
}

class _CuentaPageState extends State<CuentaPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _crearElementos(context, size),
      bottomNavigationBar: BottomBarWidget(),
    );
  }

  Widget _crearElementos(BuildContext context, Size size){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
      child: Column(
        children: <Widget>[
          SizedBox(height: size.height * 0.065),
          HeaderWidget(),
          ProductosPorCategoriasWidget(),
        ],
      ),
    );
  }
}