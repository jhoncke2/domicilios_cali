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
  int tiempoDeEntrega;
  double calificacion;
  int tiendaId;

  TiendaModel store;
  Map<String, dynamic> category;
  HorarioModel horario;
  List<Map<String, dynamic>> photos;

  //por desechar
  String imagenUrl;
  String categoria;

  //por agregar
  int stock;
  Map<String, dynamic> programado; 

  ProductoModel({
    this.id,
    this.name,
    this.precio,
    this.tipo,
    this.description,
    this.calificacion,
    this.tiempoDeEntrega,
    this.tiendaId,

    this.store,
    this.category,
    this.horario,
    this.photos,

    this.imagenUrl,
    this.categoria,
  });

  ProductoModel.fromJsonMap(Map<String, dynamic> json){
    id              = json['id'];
    name            = json['name'];
    precio          = json['precio'];
    tipo            = json['tipo'];
    description     = json['description'];
    calificacion    = (json['calificacion'])??1.0;
    category        = json['category'];
    tiempoDeEntrega = int.parse(json['tiempo_de_entrega']);
    if(json['tienda_id'] != null)
      tiendaId = json['tienda_id'];
    if(json['store']!= null)
      store           = TiendaModel.fromJsonMap(json['store']);  
    if(json['horario'] != null)
      horario = json['horario'];
    //para evitar problema de compatibilidad entre List<dynamic>(lista vacia) y List<Map<String, dynamic>>
    photos = [];
    List<Map<String, dynamic>> photosMap = (json['photos'] as List).cast<Map<String, dynamic>>().toList();
    
    photosMap.forEach((Map<String, dynamic> photo){
      photos.add(
        {
          'id':photo['id'],
          'producto_id':photo['producto_id'],
          'url':_formatPhotoUrl( photo['url'] )
        }
      );
    }); 
  }

  Map<String, String> toJson(){
    Map<String, String> json = {};
    json['name'] = name;
    json['description'] = description;
    json['precio'] = precio.toString();
    json['tipo'] = tipo;
    json['tiempo_de_entrega'] = tiempoDeEntrega.toString();
    return json;
  }

  String _formatPhotoUrl(String photoUrl){
    String url = 'https://codecloud.xyz$photoUrl';
    return url;
  }

  bool get listoParaCrear{
    return (name != null && description != null && precio != null && tipo != null);
  }
}