import 'package:domicilios_cali/src/models/productos_model.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
//Importaciones locales
import 'package:domicilios_cali/src/pages/producto_detail_page.dart';
class ProductoCardWidget extends StatelessWidget {

  ProductoModel producto;
  final percentageWidthScreen;

  ProductoCardWidget({
    this.producto,
    this.percentageWidthScreen
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    FadeInImage fadeInImage;
    try{
       fadeInImage = FadeInImage(
        fit: BoxFit.fill,
        image: NetworkImage(producto.photos[0]['url']),
        placeholder: AssetImage('assets/placeholder_images/domicilio_icono_2.jpg'),
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
              child: fadeInImage??Container(height: 0.05,),
            ),
            
            SizedBox(
              height: size.height * 0.005,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: size.width  * 0.27),
              child: Text(
                producto.name,
                style: TextStyle(
                  fontSize: size.width * 0.04,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: size.width  * 0.27),
              child: Text(
                '${producto.category['name']}',
                style: TextStyle(
                  fontSize: size.width * 0.033,
                  fontWeight: FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: size.height * 0.003,
            ),
            Container(
              width: size.width * 0.102,
              child: Center(
                child: Badge(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.003,
                    horizontal: size.width * 0.015
                  ),
                  shape: BadgeShape.square,
                  badgeColor: Colors.grey,
                  borderRadius: size.width * 0.012,
                  badgeContent: Row(
                    children: [
                      Text(
                        '${producto.calificacion}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 0.027
                        ),
                      ),
                      Icon(
                        Icons.star,
                        size: size.width * 0.029,
                        color: Colors.orange[300],
                      )
                    ],
                  ),
                ),
              ),
            ),
               
            
          ],
        ),
      ),
      onTap: (){
        Navigator.pushNamed(
          context, 
          ProductoDetailPage.route, 
          arguments: {
            'tipo':'normal', 
            'value':producto
          }
        );
      },
    );
  }
}