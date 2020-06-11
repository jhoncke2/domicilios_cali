import 'dart:core';

import 'package:domicilios_cali/src/utils/data_prueba/catalogo_producto_prueba.dart';
//importaciones locales


class ProductosModel with CatalogoProductoPrueba{
  List<ProductoModel> productos = new List();
  ProductosModel.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;
    jsonList.forEach((actual){
      final productoActual = ProductoModel.fromJsonMap(actual);
      productos.add(productoActual);
    });
  }

  /* ***********************************************
   *    Pruebas
   *********************************************** */
  List<ProductoModel> _productosPrueba = new List();

  ProductosModel.prueba(){
    for(int i = 0; i < 24; i++){
      _productosPrueba.add(
        ProductoModel(
          id: i,
          nombre: nombres[i],
          precio: precios[i],
          vendedorId: i % 5,
          imagenUrl: imagenesUrls[i],
          descripcion: descripciones[i],
          categoria: categorias[i],
          stock: stocks[i],
          calificacion: calificaciones[i],
        )
      );
    }
  }

  List<ProductoModel> get productosPrueba => _productosPrueba;

  List<ProductoModel> productosPruebaPorCategoria(String categoria){
    return _productosPrueba.where((ProductoModel producto)=>producto.categoria == categoria).toList();
  }
}

class ProductoModel{
  int id;
  String nombre;
  double precio;
  int vendedorId;
  String imagenUrl;
  String descripcion;
  String categoria;
  int stock;
  double calificacion;

  ProductoModel({
    this.id,
    this.nombre,
    this.precio,
    this.vendedorId,
    this.imagenUrl,
    this.descripcion,
    this.categoria,
    this.stock,
    this.calificacion,
  });

  ProductoModel.fromJsonMap(Map<String, dynamic> json){
    id           = json['id'];
    nombre       = json['nombre'];
    precio       = json['precio'];
    descripcion  = json['descripcion'];
    vendedorId   = json['vendedor_id'];
    imagenUrl    = json['imagen_url'];
    descripcion  = json['descripcion'];
    categoria    = json['categoria'];
    stock        = json['stock'] ;
    calificacion = json['calificacion'];
  }
}