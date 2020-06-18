import 'package:domicilios_cali/src/models/productos_model.dart';
import 'package:domicilios_cali/src/widgets/bottom_bar_widget.dart';
import 'package:domicilios_cali/src/widgets/header_widget.dart';
import 'package:flutter/material.dart';
class FavoritosPage extends StatefulWidget {
  static final route = 'favoritos';
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
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
          _crearListViewFavoritos(size, productosModel),
        ],
      ),
    );
  }

  Widget _crearTitulo(Size size){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
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
        Text(
          'Favoritos',
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

  Widget _crearListViewFavoritos(Size size, ProductosModel productosModel){
    List<ProductoModel> favoritos = _generarFavoritos(productosModel);
    List<Widget> listViewItems = [];
    favoritos.forEach((ProductoModel producto){
      listViewItems.add(
        _crearProductoFavorito(size, producto)
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
          height: size.height * 0.022,
        )
      );
      
    });
    
    return Container(
      height: size.height * 0.67,
      child: ListView(
        padding: EdgeInsets.only(top:size.height * 0.045, bottom: size.height * 0.02),
        children: listViewItems,
      ),
    );
  }

  //de prueba por ahora
  List<ProductoModel> _generarFavoritos(ProductosModel productosModel){
    List<ProductoModel> favoritos = [];
    favoritos.add(
      productosModel.productosPrueba[0],
    );
    favoritos.add(
      productosModel.productosPrueba[2],
    );
    favoritos.add(
      productosModel.productosPrueba[18],
    );
    return favoritos;
  }

  Widget _crearProductoFavorito(Size size, ProductoModel producto){
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
                  fontSize: size.width * 0.048,
                  color: Colors.black.withOpacity(0.75)
                ),
              ),
              //Completar después:
              Text(
                'Andrés Tresado',
                style: TextStyle(
                  fontSize: size.width * 0.041,
                  color: Colors.black.withOpacity(0.75)
                ),
              ),
              Icon(
                Icons.favorite,
                size: size.width * 0.073,
                color: Colors.red,
              )
            ],
          )
        ],
      )
    );
  }
}