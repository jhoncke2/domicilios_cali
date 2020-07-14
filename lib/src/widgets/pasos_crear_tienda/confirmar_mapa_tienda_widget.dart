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
      ),
    );
  }
}