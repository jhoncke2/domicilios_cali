import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:domicilios_cali/src/utils/generic_utils.dart' as utils;
class TiendaCreatePage extends StatefulWidget{
  static final route = 'tienda_create';
  @override
  _TiendaCreatePageState createState() => _TiendaCreatePageState();
}

class _TiendaCreatePageState extends State<TiendaCreatePage> {
  ImagePicker _imagePicker;

  File _imagenCedula1;
  File _imagenCedula2;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear tienda'),
      ),
      body: _crearElementos(context, size),
    );
  }

  Widget _crearElementos(BuildContext context, Size size){
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.03,
          ),
          _crearInputsImagenes(context, size),
          SizedBox(height: size.height * 0.05),
          _crearBotonDireccion(size),
        ],
      ),
    );
  }

  Widget _crearInputsImagenes(BuildContext context, Size size){
    return Column(
      children: [
        Text(
          'Introduzca ambas caras de su cédula',
          style: TextStyle(
            fontSize: size.width * 0.055,
            color: Colors.black.withOpacity(0.65),
          ),
        ),
        SizedBox(height: size.height * 0.02,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _crearInputImagen(context, size, 0),
            SizedBox(width: size.width * 0.1),
            _crearInputImagen(context, size, 1),
          ],
        ),
      ],
    );
  }

  Widget _crearInputImagen(BuildContext context, Size size, int indexCampo){
    File imagenInput = (indexCampo==0)? _imagenCedula1:_imagenCedula2;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.width * 0.25)
      ),
      height: size.height * 0.2,
      width: size.width * 0.32,
      child: (imagenInput == null)?
      RaisedButton(
        color: Colors.grey.withOpacity(0.45),
        child: Icon(
          Icons.add_box,
          size: size.width * 0.15,
        ),
        onPressed: ()=>_crearDialogSubirImagen(context, size, indexCampo),
      )
      :Stack(
        children: [
          Image.asset(imagenInput.path),
          Container(
            margin: EdgeInsets.only(left: size.width * 0.18, top: size.height * 0.06),
            child: IconButton(
              iconSize: size.width * 0.115,
              color: Colors.grey.withOpacity(0.7),
              icon: Icon(
                Icons.add_box
              ),
              onPressed: (){
                _crearDialogSubirImagen(context, size, indexCampo);
              },
            ),
          ),
        ],
      )
    );
  }

  void _crearDialogSubirImagen(BuildContext context, Size size, int indexCampo)async{
    Map<String, File> imagenMap = {};
    await utils.tomarFotoDialog(context, size, imagenMap);
    print('imagenMap:');
    print(imagenMap);
    if(imagenMap['imagen']!= null){
      if(indexCampo == 0)
        _imagenCedula1 = imagenMap['imagen'];
      else
        _imagenCedula2 = imagenMap['imagen'];
      setState(() {
        
      });
    }
  }

  Widget _crearBotonDireccion(Size size){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: size.height * 0.015),
          color: Theme.of(context).secondaryHeaderColor,
          child: Text(
            'dirección',
            style: TextStyle(
              color: Colors.white.withOpacity(0.75),
              fontSize: size.width * 0.06
            ),
          ),
          onPressed: (){

          },
        )
      ],
    );
  }
}