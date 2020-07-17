import 'dart:core';

import 'package:domicilios_cali/src/models/horarios_model.dart';
import 'package:domicilios_cali/src/models/tiendas_model.dart';
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
          name: nombres[i],
          precio: precios[i].toInt(),
          tiendaId: i % 5,
          imagenUrl: imagenesUrls[i],
          description: descripciones[i],
          categoria: categorias[i],
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
  String name;
  int precio;
  String tipo;
  String description;
  double calificacion;

  TiendaModel store;
  Map<String, dynamic> category;
  List<Map<String, dynamic>> photos;

  //por desechar
  String imagenUrl;
  int tiendaId;
  String categoria;

  //por agregar
  int stock;
  Map<String, dynamic> programado;
  HorarioModel horario;
  

  ProductoModel({
    this.id,
    this.name,
    this.precio,
    this.tipo,
    this.description,
    this.calificacion,

    this.store,
    this.category,
    this.photos,

    this.imagenUrl,
    this.tiendaId,
    this.categoria,
  });

  ProductoModel.fromJsonMap(Map<String, dynamic> json){
    id            = json['id'];
    name          = json['name'];
    precio        = json['precio'];
    tipo          = json['tipo'];
    description   = json['description'];  
    calificacion  = json['calificacion'];

    store         = TiendaModel.fromJsonMap(json['store']);
    category      = json['category'];
    //para evitar problema de compatibilidad entre List<dynamic>(lista vacia) y List<Map<String, dynamic>>
    photos        = (json['photos'] as List).cast<Map<String, dynamic>>().toList();
    photos.forEach((Map<String, dynamic> photo){
      photo['url'] = formatPhotoUrl(photo['url']);
    });
  }

  String formatPhotoUrl(String photoUrl){
    String url = 'https://codecloud.xyz$photoUrl';
    return url;
  }
}