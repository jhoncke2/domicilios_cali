import 'dart:ui';
import 'package:badges/badges.dart';
import 'package:domicilios_cali/src/widgets/bottom_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//importaciones locales
import 'package:domicilios_cali/src/models/productos_model.dart';
import 'package:domicilios_cali/src/utils/data_prueba/resenhas_prueba.dart' as resenhas;

class ProductoDetailPage extends StatefulWidget {
  static final route = 'producto_detail';
  @override
  _ProductoDetailPageState createState() => _ProductoDetailPageState();
}

class _ProductoDetailPageState extends State<ProductoDetailPage> {
  //test
  double _promedioPuntajePrueba = 4.1;

  //Código
  ProductoModel producto;
  //unidades a pedir
  int _cantidadUnidades = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    producto = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: _crearElementos(context, size, producto),
      bottomNavigationBar: BottomBarWidget(),
    );
  }

  Widget _crearElementos(BuildContext context, Size size, ProductoModel producto){
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      children: <Widget>[
        SizedBox(
          height: size.height * 0.065
        ),
        _crearTitulo(size),
        SizedBox(
          height: size.height * 0.025,
        ),
        Container(
          child: FadeInImage(
            width: size.width * 0.8,
            height: size.height * 0.25,
            fit: BoxFit.cover,
            image: NetworkImage(producto.imagenUrl),
            placeholder: AssetImage('assets/placeholder_images/domicilio_icono.png')
          ),
        ),
        SizedBox(
          height: size.height * 0.025,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: Text(
            producto.nombre,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size.width * 0.055,
              color: Colors.black.withOpacity(0.73)
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.025,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Text(
            producto.descripcion,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: size.width * 0.04,
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.07,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
          child: _crearTablaValorCantidad(context, size),
        ),
        SizedBox(
          height: size.height * 0.025,
        ),
        Container(
          padding: EdgeInsets.only(left: size.width * 0.045),
          margin: EdgeInsets.only(right: size.width * 0.38),
          child: FlatButton(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
            child: Text(
              'Programar entrega',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: size.width * 0.04,
              ),
            ),
            onPressed: (){

            },
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Divider(
          color: Colors.black.withOpacity(0.8),
        ),
        SizedBox(
          height: size.height * 0.015,
        ),
        _crearResenhas(size),
        SizedBox(
          height: size.height * 0.035,
        ),
      ],
    );
  }

  Widget _crearTitulo(Size size){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          iconSize: size.width * 0.06,
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey.withOpacity(0.8),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        
        Text(
          'Elmo Staza',
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: size.width * 0.075
          ),
        ),
        SizedBox(
          width: size.width * 0.1,
        ),

      ],
    );
  }

  Widget _crearTablaValorCantidad(BuildContext context, Size size){
    return Table(
      border: TableBorder(

      ),
      children: <TableRow>[
        TableRow(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1.0
              )
            )
          ),
          children: <Widget>[
            Text(
              'Valor',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size.width * 0.044,
              ),
            ),
            Text(
              'Cantidad',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size.width * 0.044,
              ),
            )
          ]
        ),
        TableRow(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top:size.height * 0.015),
              child: Text(
                '\$${producto.precio * _cantidadUnidades}',
                textAlign: TextAlign.center, 
                style: TextStyle(
                  fontSize: size.width * 0.045
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: size.width * 0.13,
                  child: IconButton(
                    color: Colors.black.withOpacity(0.8),
                    icon: Icon(
                      Icons.remove,
                      size: size.height * 0.035,
                    ),     
                    onPressed: (){
                     if(_cantidadUnidades > 1){
                       setState(() {
                        _cantidadUnidades--;
                      });
                     }
                    },
                  ),
                ),
                SizedBox(
                  width: size.width * 0.012,
                ),
                Text(
                  _cantidadUnidades.toString(),
                  
                  style: TextStyle(
                    fontSize: size.width * 0.045
                  ),
                ),
                SizedBox(
                  width: size.width * 0.012,
                ),
                IconButton(
                  color: Colors.black.withOpacity(0.8),
                  icon: Icon(
                    Icons.add,
                    size: size.height * 0.035,
                  ),
                  
                  onPressed: (){
                    setState(() {
                      if(_cantidadUnidades < producto.stock){
                        _cantidadUnidades++;
                      }
                    });
                  },
                ),
              ],
            )
          ]
        ),
        TableRow(
          children: <Widget>[
            Container(),
            Column(
              children: <Widget>[
                Text(
                  'unidades',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.045,
                  ),
                ),
                Text(
                  'Cantidad disponible: ${producto.stock}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.038,
                  ),
                ),
              ],
            ),
            
          ]
        )

      ],
    );
  }

  Widget _crearResenhas(Size size){
    List<Widget> _columnChildren = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Reseñas',
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: size.width * 0.06
            ),
          ),
          _crearEstrellasPuntaje(size),
        ],
      ),
      SizedBox(
        height: size.height * 0.035,
      ),
    ];
    resenhas.resenhas.forEach((Map<String, dynamic> resenha){
      _columnChildren.add(
        _crearResenha(size, resenha)
      );
      _columnChildren.add(
        SizedBox(
          height: size.height * 0.055,
        )
      );
    });
    return Column(
      children: _columnChildren,
    );
  }

  Widget _crearEstrellasPuntaje(Size size){
    return Row(
      children: <Widget>[
        _crearIconoEstrella(size, 1),
        _crearIconoEstrella(size, 2),
        _crearIconoEstrella(size, 3),
        _crearIconoEstrella(size, 4),
        _crearIconoEstrella(size, 5),
      ],
    );
  }

  Widget _crearIconoEstrella(Size size, int index){
    IconData iconData = (_promedioPuntajePrueba >= index)? Icons.star
                      : (_promedioPuntajePrueba >= index-0.5)? Icons.star_half
                      : Icons.star_border;
    return Icon(
      iconData,
      color: Colors.orangeAccent,
      size: size.width * 0.055,
    );
  }

  Widget _crearResenha(Size size, Map<String, dynamic> resenha){
    return Container(
      decoration: BoxDecoration(
        //color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipOval(
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      width: size.width * 0.11,
                      height: size.height * 0.07,
                      image: NetworkImage(resenha['url_foto']),
                      placeholder: AssetImage('assets/placeholder_images/user.png'),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.045,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        resenha['nombre_usuario'],
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.85),
                          fontSize: size.width * 0.046,
                        ),
                      ),
                      Text(
                        resenha['fecha'],
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontSize: size.width * 0.035,
                        ),
                      ),
                    ],
                  ),
                ],   
              ),
              
              SizedBox(
                width: size.width * 0.03,
              ),
              Container(
                width: size.width * 0.14,
                height: size.height * 0.039,
                child: Center(
                  child: Badge(
                    shape: BadgeShape.square,
                    badgeColor: Colors.grey,
                    borderRadius: size.width * 0.013,
                    badgeContent: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Text(
                          '${resenha['calificacion']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 0.038
                          ),
                        ),
                        Icon(
                          Icons.star,
                          size: size.width * 0.045,
                          color: Colors.orangeAccent,
                        )
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
          SizedBox(
            height: size.height * 0.013,
          ),
          Text(
            resenha['comentario'],
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: size.width * 0.04,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}