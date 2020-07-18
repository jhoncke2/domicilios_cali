import 'package:domicilios_cali/src/bloc/productos_bloc.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/tienda_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:domicilios_cali/src/utils/data_prueba/catalogo_producto_prueba.dart';
import 'package:domicilios_cali/src/widgets/header_widget.dart';

import 'package:domicilios_cali/src/utils/generic_utils.dart' as utils;

class ProductoCreatePage extends StatefulWidget with CatalogoProductoPrueba{
  static final route = 'productoCreate';
  @override
  _ProductoCreatePageState createState() => _ProductoCreatePageState();
}

class _ProductoCreatePageState extends State<ProductoCreatePage>{
  BuildContext context;
  TiendaBloc tiendaBloc;
  ProductosBloc productosBloc;

  List<File> _photos;
  String _dropdownCategoriaValue = '';
  String _nombreValue = '';

  @override
  void initState() { 
    _photos = [];
    _dropdownCategoriaValue = widget.categoriasUnitarias[0];
    super.initState(); 
  }

  @override
  Widget build(BuildContext appContext) {
    context = appContext;
    Size size = MediaQuery.of(context).size;
    productosBloc = Provider.productosBloc(context);
    tiendaBloc = Provider.tiendaBloc(context);
    return Scaffold(
      body: _crearElementos(context, size),
    );
  }

  Widget _crearElementos(BuildContext context, Size size){
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.075),
      children: <Widget>[
        SizedBox(
          height: size.height * 0.065,
        ),
        HeaderWidget(),
        SizedBox(
          height: size.height * 0.025,
        ),
        _crearTitulo(size),
        SizedBox(
          height: size.height * 0.015,
        ),
        _crearInputsImagenes(context, size),
        SizedBox(
          height: size.height * 0.055,
        ),
        _crearDropdownCategorias(size),
        SizedBox(
          height: size.height * 0.01,
        ),
        _crearInputNombre(size),
        SizedBox(
          height: size.height * 0.015,
        ),
        _crearInputDescripcion(size),
        SizedBox(
          height: size.height * 0.035,
        ),
        Divider(
          color: Colors.black.withOpacity(0.8),
          height: size.height * 0.015,
        ),
        SizedBox(
          height: size.height * 0.015,
        ),
        _crearInputValorUnitario(size),
        SizedBox(
          height: size.height * 0.025,
        ),
        _crearBotonProgramarVenta(size),
        SizedBox(
          height: size.height * 0.025,
        ),
        _crearBotonSubmit(size),
        SizedBox(
          height: size.height * 0.05,
        ),
      ],
    );
  }

  Widget _crearTitulo(Size size){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon( Icons.arrow_back_ios ),
          color: Colors.grey.withOpacity(0.8),
          iconSize: size.width * 0.075,
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        Text(
          'Crear producto',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.7),
            fontSize: size.width * 0.062
          ),
        ),
        SizedBox(
          width: size.width * 0.05,
        )
      ],
    );
  }

  Widget _crearInputsImagenes(BuildContext context, Size size){
    List<Widget> rowItems = [];
    _photos.forEach((File photo){
      rowItems.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
          child: ClipOval(
            child: Image.asset(
              photo.path,
              fit: BoxFit.fill,
              width: size.width * 0.23,
              height: size.height * 0.13,
              
            ),
          ),
        )
      );
    });
    if(_photos.length < 4){
      rowItems.add(
        IconButton(
          icon: Icon(
            Icons.add_box,         
          ),
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          iconSize: size.width * 0.12,
          onPressed: (){
            _subirImagenes(context, size);
          },
        )
      );
    }
    return Container(
      height: size.height * 0.13,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: rowItems,
      ),
    );
  }

  Future<void> _subirImagenes(BuildContext context, Size size)async{
    Map<String, File> imagenMap = {};
    await utils.tomarFotoDialog(context, size, imagenMap);
    if(imagenMap['imagen'] != null){
      _photos.add(imagenMap['imagen']);
      setState(() {
        
      });
    }
  }

  Widget _crearPopUpCategorias(Size size){
    List<PopupMenuEntry<int>> categoriasItems = [];
  }

  Widget _crearDropdownCategorias(Size size){
    List<DropdownMenuItem<String>> items = widget.categoriasUnitarias.map((String categoria){
      return DropdownMenuItem<String>(
        child: Text(
          categoria,
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: size.width * 0.045,
          ),
        ),
        value: categoria,
      );
      
    }).toList();
    print('items: $items');

    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0.0),
        width: size.width * 0.5,
        child: DropdownButtonFormField(
          decoration: InputDecoration(           
            contentPadding: EdgeInsets.all(0.0),
            labelText: 'categoria',
            labelStyle: TextStyle(
              color: Colors.black.withOpacity(0.85),
              fontSize: size.width * 0.043
            ),
            enabledBorder: InputBorder.none
          ),
          value: _dropdownCategoriaValue,
          hint: Text(
            'categoria',
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: size.width * 0.042
            ),
          ),
          
          items: items,
          onChanged: (String newValue){
            _dropdownCategoriaValue = newValue;
            setState(() {
              
            });
          },
        ),
      ),
    );
  }

  Widget _crearInputNombre(Size size){
    return Center(
      child: Container(
        width: size.width * 0.6,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Nombre del producto',
            labelStyle: TextStyle(
              fontSize: size.width * 0.043,
              color: Colors.black.withOpacity(0.67)
            )
          ),
        ),
      ),
    );
  }

  Widget _crearInputDescripcion(Size size){
    return Center(
      child: Container(
        width: size.width * 0.8,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Descripción del producto',
            labelStyle: TextStyle(
              fontSize: size.width * 0.043,
              color: Colors.black.withOpacity(0.67)
            )
          ),
        ),
      ),
    );
  }

  Widget _crearInputValorUnitario(Size size){
    return Center(
      child: Container(
        width: size.width * 0.5,
        child: TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Valor unitario',
            labelStyle: TextStyle(
              fontSize: size.width * 0.043,
              color: Colors.black.withOpacity(0.67)
            ),
            prefixIcon: Icon(
              Icons.attach_money
            )
          ),
        ),
      ),
    );
  }

  Widget _crearBotonProgramarVenta(Size size){
    return Container(
      width: size.width * 0.45,
      child: FlatButton(
        child: Row(
          children: <Widget>[
            Text(
              'Programar venta',
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: size.width * 0.043
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.grey.withOpacity(0.8),
              size: size.width * 0.07,
            )
          ],
        ),
        onPressed: (){

        },
      ),
    );
  }

  Widget _crearBotonSubmit(Size size){
    return Center(
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size.width * 0.045)
        ),
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical:size.height * 0.006),
        color: Colors.grey.withOpacity(0.75),
        child: Text(
          'Guardar',
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: size.width * 0.045
          ),
        ),    
        onPressed: (){

        },
      ),
    );
  }
}