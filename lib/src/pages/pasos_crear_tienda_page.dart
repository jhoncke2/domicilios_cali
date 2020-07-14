import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/tienda_bloc.dart';
import 'package:domicilios_cali/src/pages/cuenta_page.dart';
import 'package:domicilios_cali/src/pages/perfil_page.dart';
import 'package:domicilios_cali/src/widgets/pasos_crear_tienda/confirmar_mapa_tienda_widget.dart';
import 'package:domicilios_cali/src/widgets/pasos_crear_tienda/crear_direccion_tienda_widget.dart';
import 'package:domicilios_cali/src/widgets/pasos_crear_tienda/crear_domiciliarios_tienda_widget.dart';
import 'package:domicilios_cali/src/widgets/pasos_crear_tienda/crear_horarios_tienda_page.dart';
import 'package:domicilios_cali/src/widgets/pasos_crear_tienda/subir_cedula_tienda_widget.dart';
import 'package:flutter/material.dart';
class PasosCrearTiendaPage extends StatefulWidget {
  static final route = 'pasos_crear_tienda';
  @override
  _PasosCrearTiendaPageState createState() => _PasosCrearTiendaPageState();

}

class _PasosCrearTiendaPageState extends State<PasosCrearTiendaPage> {
  int _indexPaso = 1;
  @override
  Widget build(BuildContext context) {
    TiendaBloc tiendaBloc = Provider.tiendaBloc(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[

          ],
        )
      ),
    );
  }

  Widget _crearListView(Size size, TiendaBloc tiendaBloc){
    return ListView(
      children: <Widget>[

      ],
    );
  }

}