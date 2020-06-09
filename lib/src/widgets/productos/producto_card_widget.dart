import 'package:flutter/material.dart';
//import 'package:badges/badges.dart';
//Importaciones locales
import 'package:domicilios_cali/src/models/productos_model.dart';
import 'package:domicilios_cali/src/pages/producto_detail_page.dart';
class ProductoCardWidget extends StatelessWidget {

  Size size;
  ProductoModel producto;
  double percentageWidthScreen;

  ProductoCardWidget({
    this.size,
    this.producto,
    this.percentageWidthScreen
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    FadeInImage fadeInImage;
    try{
       fadeInImage = FadeInImage(
                  //fit: BoxFit.fill,
        image: NetworkImage(producto.imagenUrl),
        placeholder: AssetImage('assets/placeholder_images/domicilio_icono.png'),
      );
    }catch(err){
      print('error: $err');
    }
    return GestureDetector(
      child: Container(
        width: size.width * 0.27,
        padding: EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: size.height * 0.12,
              width: size.width * 0.27,
              child: fadeInImage??Container(),
            ),
            
            SizedBox(
              height: size.height * 0.015,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: size.width  * 0.27),
              child: Text(
                producto.nombre,
                style: TextStyle(
                  fontSize: 17.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
                //\$ para que tome a $ como un caracter normal y no como uno especial.
            '${producto.categoria.toString()}',
              style: TextStyle(
                fontSize: size.width * 0.035,  
              ),
            ),
               
            
          ],
        ),
      ),
      onTap: (){
        Navigator.pushNamed(context, ProductoDetailPage.route, arguments: producto);
      },
    );
  }
}