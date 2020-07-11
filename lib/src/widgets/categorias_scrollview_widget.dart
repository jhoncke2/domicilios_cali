import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:domicilios_cali/src/utils/data_prueba/catalogo_producto_prueba.dart';
class CategoriasScrollviewWidget extends StatefulWidget with CatalogoProductoPrueba{

  @override
  _CategoriasScrollviewWidgetState createState() => _CategoriasScrollviewWidgetState();
}
/*
  Scrollview de categorias para la lista de productos
*/
class _CategoriasScrollviewWidgetState extends State<CategoriasScrollviewWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.14,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           Container(
             padding: EdgeInsets.only(left: size.width * 0.07),
             child: Text(
              'Categorias',
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.05
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.003,
          ),
          _crearListView(size),
        ],
      ),
    );
  }

  Widget _crearListView(Size size){
    List<String> categorias = widget.categoriasUnitarias;
    List<Container> categoriasItems = [];
    for(int i = 0; i < categorias.length; i++){
      categoriasItems.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
          width: size.width * 0.2,
          padding: EdgeInsets.all(size.width * 0.02),
          color: (i%2 == 0)? Theme.of(context).primaryColor : Color.fromRGBO(192, 214, 81, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                widget.categoriasIconos[i],
                color: Colors.white.withOpacity(0.9),
                size: size.width * 0.11,
              ),
              ConstrainedBox(
              constraints: BoxConstraints(maxWidth: size.width  * 0.25),
              child: Text(
                categorias[i],
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: size.width * 0.028,
                  fontWeight: FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            /*
            Text(
              categorias[i],
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: size.width * 0.027
              ),
            )
            */
            ],
          ),
        )
      );
    }
    return Container(
      height: size.height * 0.1,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categoriasItems, 
      ),
    );
  }
}