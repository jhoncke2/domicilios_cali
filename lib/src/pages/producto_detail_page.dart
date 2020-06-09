import 'dart:ui';
import 'package:domicilios_cali/src/pages/carrito_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//importaciones locales
import 'package:domicilios_cali/src/models/productos_model.dart';
class ProductoDetailPage extends StatefulWidget {
  static final route = 'producto_detail';
  @override
  _ProductoDetailPageState createState() => _ProductoDetailPageState();
}

class _ProductoDetailPageState extends State<ProductoDetailPage> {
  //test
  final _horariosPrueba = [
    {
      'dias': 'Lunes a viernes',
      'horas': [
        '7:00am a 11:00am',
        '1:30pm a 8:30pm',
      ]
    },
    {
      'dias':'Sábado y domingo',
      'horas':[
        '8:00am a 10:30am',
        '2:00pm a 6:30pm',
      ]
    }
  ];

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
      appBar: AppBar(
        title: Center(child: Text('Doña Blanca corporation')),
        actions: <Widget>[
          FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0.0,
            child: Icon(Icons.shopping_cart),
            onPressed: (){
              Navigator.pushNamed(context, CarritoPage.route);
            },
          )
        ],
      ),
      body: _crearElementos(context, size, producto),
      bottomNavigationBar: _crearFooter(context, size),
    );
  }

  Widget _crearElementos(BuildContext context, Size size, ProductoModel producto){
    return ListView(
      children: <Widget>[
        Container(
          child: FadeInImage(
            //height: size.height * 0.45,
            fit: BoxFit.fitWidth,
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
              fontSize: size.width * 0.09,
              color: Colors.black54
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
              fontSize: size.width * 0.045,
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
          height: size.height * 0.06,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: _crearTablaHorarios(context, size),
        ),
        SizedBox(
          height: size.height * 0.035,
        ),
        Container(
          padding: EdgeInsets.only(left: size.width * 0.01),
          child: FlatButton(
            child: Text(
              'Programar entrega',
              style: TextStyle(
                color: Colors.deepOrangeAccent,
                fontSize: size.width * 0.038,
              ),
            ),
            onPressed: (){

            },
          ),
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
                IconButton(
                  icon: Icon(Icons.remove),
                  iconSize: size.height * 0.040,
                  color: Colors.black,
                  onPressed: (){
                   if(_cantidadUnidades > 1){
                     setState(() {
                      _cantidadUnidades--;
                    });
                   }
                  },
                ),
                SizedBox(
                  width: size.width * 0.035,
                ),
                Text(
                  _cantidadUnidades.toString(),
                  
                  style: TextStyle(
                    fontSize: size.width * 0.045
                  ),
                ),
                SizedBox(
                  width: size.width * 0.035,
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  iconSize: size.height * 0.040,
                  color: Colors.black,
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
            Text(
              'Pago en efectivo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size.width * 0.039,
              ),
            ),
            Text(
              '${producto.stock} unidades disponibles',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size.width * 0.038,
              ),
            ),
          ]
        )

      ],
    );
  }

  Widget _crearTablaHorarios(BuildContext context, Size size){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: size.width * 0.04),
          child: Text(
            'Horarios de entrega',
            style: TextStyle(
              fontSize: size.width * 0.04
            ),
          ),        
        ),
        Container(
          padding: EdgeInsets.only(left: size.width * 0.04),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Colors.black,
              )
            )
          ),
          child: Column(
            children: _horariosPrueba.map((horario){
              return _crearWidgetHorarioDias(size, horario);
            }).toList(),
          ),
        ),
      ]
    );
  }

  Widget _crearWidgetHorarioDias(Size size, dynamic horario){
    List<Widget> horariosDiasWidgetList = new List();
    horariosDiasWidgetList.add(Text(
      horario['dias'],
      style: TextStyle(
        fontSize: size.width * 0.045
      ),
    ));
    horariosDiasWidgetList.add(
      SizedBox(height: size.height * 0.005,),
    );

    horario['horas'].forEach((hora){
      horariosDiasWidgetList.add(
        Text(
          hora,
          style: TextStyle(
            fontSize: size.width * 0.04,
          ),
        )
      );
    });
    return Container(
      padding: EdgeInsets.symmetric(vertical:size.height * 0.011),
      child: Column(
        children: horariosDiasWidgetList,
      ),
    );
  }

  Widget _crearFooter(BuildContext context, Size size){
    return BottomAppBar(
      color: Theme.of(context).backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: Row(
              children: <Widget>[
                Icon(Icons.add_shopping_cart),
                SizedBox(
                  width: size.width * 0.02,
                ),
                Text('Agregar al carrito'),
              ],
            ),
            onPressed: (){

            },
          )
        ],
      ),
    );
  }
}