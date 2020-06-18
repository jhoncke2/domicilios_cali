import 'package:domicilios_cali/src/models/productos_model.dart';
import 'package:domicilios_cali/src/widgets/bottom_bar_widget.dart';
import 'package:domicilios_cali/src/widgets/header_widget.dart';
import 'package:flutter/material.dart';
class HistorialPage extends StatefulWidget {
  static final route = 'historial';
  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ProductosModel productosModel = ProductosModel.prueba();
    return Scaffold(
      body: _crearElementos(size, productosModel),
      bottomNavigationBar: BottomBarWidget(),
    );
  }

  Widget _crearElementos(Size size, ProductosModel productosModel){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.064,
          ),
          HeaderWidget(),
          SizedBox(
            height: size.height * 0.01,
          ),
          _crearTitulo(size),
          _crearListViewHistorial(size, productosModel),
        ],
      ),
    );
  }

  Widget _crearTitulo(Size size){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        /*
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: size.width * 0.05,
            color: Colors.black.withOpacity(0.6),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        */
        Text(
          'Historial',
          style: TextStyle(
            fontSize: size.width * 0.067,
            color: Colors.black.withOpacity(0.65),
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(
          width: size.width * 0.05,
        )
      ],
    );
  }

  Widget _crearListViewHistorial(Size size, ProductosModel productosModel){
    List<ProductoModel> favoritos = _generarHistorial(productosModel);
    List<Widget> listViewItems = [];
    favoritos.forEach((ProductoModel producto){
      listViewItems.add(
        _crearProductoHistorial(size, producto)
      );
      
      listViewItems.add(
        Divider(
          color: Colors.grey.withOpacity(0.275),
          height: size.height * 0.045,
          thickness: size.height * 0.0028,
          indent: size.width * 0.15,
          endIndent: size.width * 0.15,
        )
      );
      listViewItems.add(
        SizedBox(
          height: size.height * 0.018,
        )
      );
      
    });
    
    return Container(
      height: size.height * 0.71,
      child: ListView(
        padding: EdgeInsets.only(top:size.height * 0.045, bottom: size.height * 0.02),
        children: listViewItems,
      ),
    );
  }

  //de prueba por ahora
  List<ProductoModel> _generarHistorial(ProductosModel productosModel){
    List<ProductoModel> favoritos = [];
    favoritos.add(
      productosModel.productosPrueba[1],
    );
    favoritos.add(
      productosModel.productosPrueba[3],
    );
    favoritos.add(
      productosModel.productosPrueba[10],
    );
    favoritos.add(
      productosModel.productosPrueba[11],
    );
    favoritos.add(
      productosModel.productosPrueba[19],
    );
    return favoritos;
  }

  Widget _crearProductoHistorial(Size size, ProductoModel producto){
    return Container(
      child: Row(
        children: <Widget>[
          FadeInImage(
            width: size.width * 0.3,
            height: size.height * 0.115,
            fit: BoxFit.fill,
            placeholder: AssetImage('assets/placeholder_images/domicilio_icono_2.jpg'),
            image: NetworkImage(producto.imagenUrl),
          ),
          SizedBox(
            width: size.width * 0.038,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                producto.nombre,
                style: TextStyle(
                  fontSize: size.width * 0.049,
                  color: Colors.black.withOpacity(0.85)
                ),
              ),
              //Completar después:
              Text(
                'Andrés Tresado',
                style: TextStyle(
                  fontSize: size.width * 0.041,
                  color: Colors.black.withOpacity(0.8)
                ),
              ),
              Text(
                'cantidad: 2',
                style: TextStyle(
                  fontSize: size.width * 0.037,
                  color: Colors.black.withOpacity(0.8)
                ),
              ),
              Text(
                '20-06-2020',
                style: TextStyle(
                  fontSize: size.width * 0.037,
                  color: Colors.black.withOpacity(0.8)
                ),
              ),
              Text(
                'Pagado en efectivo',
                style: TextStyle(
                  fontSize: size.width * 0.039,
                  color: Colors.black.withOpacity(0.8)
                ),
              ),
            ],
          )
        ],
      )
    );
  }
}