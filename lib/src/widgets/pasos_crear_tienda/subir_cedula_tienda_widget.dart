import 'dart:io';
import 'package:flutter/material.dart';
import 'package:domicilios_cali/src/utils/generic_utils.dart' as utils;
class SubirCedulaTiendaWidget extends StatefulWidget {

  @override
  _SubirCedulaTiendaWidgetState createState() => _SubirCedulaTiendaWidgetState();
}

class _SubirCedulaTiendaWidgetState extends State<SubirCedulaTiendaWidget> {
  File _imagenCedula1;
  File _imagenCedula2;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.01,
          ),
          Center(
            child: Text(
              'Introduzca ambas caras de su cédula',
              style: TextStyle(
                fontSize: size.width * 0.055,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.04,),
          _crearInputImagen(context, size, 0),
          SizedBox(height: size.height * 0.04,),
          _crearInputImagen(context, size, 1),
        ],
      ),
    );
  }

  Widget _crearInputImagen(BuildContext context, Size size, int indexCampo){
    File imagenInput = (indexCampo==0)? _imagenCedula1:_imagenCedula2;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.width * 0.25)
      ),
      height: size.height * 0.3,
      width: size.width * 0.5,
      child: (imagenInput == null)?
      RaisedButton(
        color: Colors.grey.withOpacity(0.45),
        child: Icon(
          Icons.add_box,
          size: size.width * 0.2,
          color: Colors.black.withOpacity(0.65),
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
}