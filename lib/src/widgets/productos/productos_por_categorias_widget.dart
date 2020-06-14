import 'package:domicilios_cali/src/models/productos_model.dart';
import 'package:domicilios_cali/src/utils/menu_categorias.dart';
import 'package:domicilios_cali/src/widgets/productos/producto_card_widget.dart';
import 'package:flutter/material.dart';
class ProductosPorCategoriasWidget extends StatefulWidget {

  @override
  _ProductosPorCategoriasWidgetState createState() => _ProductosPorCategoriasWidgetState();
}

class _ProductosPorCategoriasWidgetState extends State<ProductosPorCategoriasWidget> with MenuCategorias{
  ProductosModel _productosModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productosModel = ProductosModel.prueba();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.75,
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: categorias.map((categoria){
          return _crearListaPorCategoria(context, size, categoria['nombre']);
        }).toList(),
      ),
    );
  }

  Widget _crearListaPorCategoria(BuildContext context, Size size, String nombreCategoria){
    List<ProductoModel> productosPorCategoria = _productosModel.productosPruebaPorCategoria(nombreCategoria);
    List<Widget> productosWidgets = [];
    for(int i = 0; i < productosPorCategoria.length; i++){
      productosWidgets.add(
        Container(
          //el primer elemento no tiene padding left y el último no tiene padding right
          padding: (i>0 && i < productosPorCategoria.length -1 )?
            EdgeInsets.symmetric(horizontal: size.width * 0.031)
            :(i==0)? EdgeInsets.only(right: size.width * 0.031)
            : EdgeInsets.only(left: size.width * 0.031),
          child: ProductoCardWidget(producto: productosPorCategoria[i])
        )
      );
    }
    return Container(
      height: size.height * 0.28,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            nombreCategoria,
            style: TextStyle(
              fontSize: size.width * 0.055,
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Container(
            height: size.height * 0.22,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: productosWidgets,
            ),
          ),
        ],
      ),
    );
  }
}