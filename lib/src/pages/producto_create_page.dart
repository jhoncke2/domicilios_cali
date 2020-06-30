import 'package:domicilios_cali/src/utils/data_prueba/catalogo_producto_prueba.dart';
import 'package:flutter/material.dart';
class ProductoCreatePage extends StatefulWidget with CatalogoProductoPrueba{
  static final route = 'productoCreate';
  @override
  _ProductoCreatePageState createState() => _ProductoCreatePageState();
}

class _ProductoCreatePageState extends State<ProductoCreatePage>{
  String _dropdownCategoriaValue = '';
  String _nombreValue = '';

  @override
  void initState() { 
    super.initState();
    _dropdownCategoriaValue = widget.categoriasUnitarias[0];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _crearElementos(size),
    );
  }

  Widget _crearElementos(Size size){
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.075),
      children: <Widget>[
        SizedBox(
          height: size.height * 0.065,
        ),
        //HeaderWidget(),
        SizedBox(
          height: size.height * 0.025,
        ),
        _crearTitulo(size),
        SizedBox(
          height: size.height * 0.015,
        ),
        _crearInputsImagenes(size),
        SizedBox(
          height: size.height * 0.005,
        ),
        _crearSugerenciaImagenes(size),
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

  Widget _crearInputsImagenes(Size size){
    return Container(
      height: size.height * 0.25,
      width: size.width * 0.085,
      color: Colors.grey.withOpacity(0.8),
    );
  }

  Widget _crearSugerenciaImagenes(Size size){
    return Text(
      '(Se recomienda una foto en donde almacene materia prima y se realiza el procesamiento de los productos)',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black.withOpacity(0.8),
        fontSize: size.width * 0.043,
      ),
    );
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