import 'package:domicilios_cali/src/models/lugares_model.dart';
import 'package:domicilios_cali/src/widgets/mapa_tienda_widget.dart';
import 'package:flutter/material.dart';
class ConfirmarMapaTiendaWidget extends StatefulWidget {
  @override
  _ConfirmarMapaTiendaWidgetState createState() => _ConfirmarMapaTiendaWidgetState();
}

class _ConfirmarMapaTiendaWidgetState extends State<ConfirmarMapaTiendaWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: MapaTiendaWidget(
        LugarModel(
          latitud: 0.0,
          longitud: 0.0
        ),
      ),
    );
  }
}