import 'package:domicilios_cali/src/widgets/bottom_bar_widget.dart';
import 'package:domicilios_cali/src/widgets/header_widget.dart';
import 'package:flutter/material.dart';
class VentasPage extends StatelessWidget {
  static final route = 'ventas';
  BuildContext context;
  Size size;

  @override
  Widget build(BuildContext appContext) {
    context = appContext;
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: _crearElementos(),
      bottomNavigationBar: BottomBarWidget(),
    );
  }

  Widget _crearElementos(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.06,
          ),
          HeaderWidget(),
          SizedBox(
            height: size.height * 0.01
          ),
          Text(
            'Ventas',
            style: TextStyle(
              fontSize: size.width * 0.065,
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),
          ),
          _crearListviewVentas()
        ],
      ),
    );
  }

  Widget _crearListviewVentas(){
    return Container(
      height: size.height * 0.71,
      child: ListView(),
    );
  }
}