import 'package:domicilios_cali/src/models/productos_model.dart';
import 'package:flutter/material.dart';
//Importaciones
import 'package:domicilios_cali/src/widgets/productos/producto_card_widget.dart';

class ProductosWidget extends StatefulWidget {
  //lista estática de productos ingresada desde clase padre, en caso de que se quiera desplegar esa lista especifica de elementos.

  double horizontalMarginPercent;
  double horizontalPaddinghPercent;
  double heightPercent;
  double widthPercent;
  bool scrollable;

  ProductosWidget({
    this.horizontalMarginPercent = 0.015,
    this.horizontalPaddinghPercent = 0.0,
    this.heightPercent,
    this.widthPercent = 0.76,
    this.scrollable = true,
  });

  @override
  _ProductosWidgetState createState() => _ProductosWidgetState();
}

class _ProductosWidgetState extends State<ProductosWidget> {
  ProductosModel _productosModel;
  List<ProductoModel> _productosAMostrar;
  @override
  void initState() { 
    super.initState();
    _productosModel = new ProductosModel.prueba();
    _productosAMostrar = _productosModel.productosPrueba;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * widget.horizontalMarginPercent),
      padding: EdgeInsets.symmetric(vertical: 0),
      //0.18 es el porcentaje de width de pantalla que tiene cada card (?).
      height: size.height * 0.755,
      width: size.width,     
      decoration: BoxDecoration(
        color: Colors.white70,
      ),
      /**
       * En 2 casos lo necesito scrollable, en 1 no
       */
      child: GridView.count(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.035),
          crossAxisCount: 3,
          mainAxisSpacing: size.width * 0.028,
          crossAxisSpacing: size.height * 0.03,
          childAspectRatio: 0.58,
          children: _productosAMostrar.map((producto) => ProductoCardWidget(producto: producto,)).toList(),
      ),
    );
  }

  /*
  child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: size.width * 0.028,
          crossAxisSpacing: size.height * 0.03,
          childAspectRatio: 0.655,
        ),
        itemBuilder: (BuildContext context, int index){
          return ProductoCardWidget(producto: productosAMostrar[index]);
        },
        itemCount: productosAMostrar.length,
      ),
  */
}