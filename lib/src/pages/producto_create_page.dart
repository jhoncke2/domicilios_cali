import 'package:domicilios_cali/src/bloc/productos_bloc.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/tienda_bloc.dart';
import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:domicilios_cali/src/models/productos_model.dart';
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
  Size size;
  String token;
  TiendaBloc tiendaBloc;
  ProductosBloc productosBloc;

  List<Map<String, dynamic>> _categories;

  List<File> _photos;
  ProductoModel _producto;
  int _dropdownCategoryValue;
  String _nombreValue = '';

  @override
  void initState(){
    _categories = [];
    _producto = new ProductoModel(
      tipo: 'normal'
    ); 
    _photos = [];
    //_dropdownCategoriaValue = widget.categoriasUnitarias[0];
    super.initState(); 
  }

  @override
  Widget build(BuildContext appContext) {
    context = appContext;
    size = MediaQuery.of(context).size;
    token = Provider.usuarioBloc(context).token;
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
        _crearSwitchTipoProducto(),
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
          color: Theme.of(context).secondaryHeaderColor.withOpacity(0.75),
          iconSize: size.width * 0.145,
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

    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0.0),
        width: size.width * 0.3,
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: productosBloc.categoriasStream,
          builder: (BuildContext appContext, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if(snapshot.hasData){
              List<DropdownMenuItem<int>> categoriesItems = _crearCategoriesItems(snapshot.data);
              return DropdownButtonFormField<int>(            
                decoration: InputDecoration(
                  enabled: true,
                  contentPadding: EdgeInsets.all(0.0),
                  //labelText: 'categoria',
                  labelStyle: TextStyle(
                    color: Colors.black.withOpacity(0.85),
                    fontSize: size.width * 0.043
                  ),
                  enabledBorder: InputBorder.none
                ),
                value: _dropdownCategoryValue,
                hint: Text(
                  'categoria',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: size.width * 0.042
                  ),
                ),
                
                items: categoriesItems,
                onChanged: (int newValue){
                  _dropdownCategoryValue = newValue;
                  setState(() {
                    
                  });
                },
              );
            }else{
              return CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              );
            }
          }
        ),
      ),
    );
  }

  List<DropdownMenuItem<int>> _crearCategoriesItems(List<Map<String, dynamic>> categories){
    //_dropdownCategoryValue = categories[0]['id'];
    List<DropdownMenuItem<int>> categoriesItems = [];
    categories.forEach((Map<String, dynamic> category){
      categoriesItems.add(
        DropdownMenuItem<int>(
          child: Text(
            category['name'],
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: size.width * 0.043,
            ),
          ),
          value: category['id'],
        )
      );
    });
    return categoriesItems;
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
          onChanged: (String newValue){
            _producto.name = newValue;
          },
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
          onChanged: (String newValue){
            _producto.description = newValue;
          },
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
          onChanged: (String newValue){
            _producto.precio = int.parse(newValue);
          },
        ),
      ),
    );
  }

  Widget _crearSwitchTipoProducto(){
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Producto \n venta diaria',
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: size.width * 0.04
            ),
          ),
          SizedBox(
            width: size.width * 0.03,
          ),
          Switch(
            value: (_producto.tipo == 'programado'),
            inactiveThumbColor: Colors.white,
            activeColor: Colors.white,
            focusColor: Colors.white,
            activeTrackColor: Theme.of(context).secondaryHeaderColor,
            inactiveTrackColor: Theme.of(context).secondaryHeaderColor,
            onChanged: (bool selected){
              _producto.tipo = (selected)? 'programado' : 'normal';
              setState(() {
                
              });
            },
          ),
          SizedBox(
            width: size.width * 0.03,
          ),
          Text(
            'Producto \n programado',
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: size.width * 0.04
            ),
          ),
        ],
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
          _submit();
        },
      ),
    );
  }

  void _submit()async{
    if(_producto.listoParaCrear && _photos.length > 0 && _dropdownCategoryValue != null){
      Map<String, dynamic> response = await productosBloc.crearProducto(token, _producto, _photos, _dropdownCategoryValue);
      if(response['status'] != null){
        Navigator.of(context).pop();
      }
    }
  }
}