import 'dart:io';

import 'package:domicilios_cali/src/models/domiciliarios_model.dart';
import 'package:flutter/material.dart';
class CrearDomiciliariosTiendaWidget extends StatefulWidget {

  @override
  _CrearDomiciliariosTiendaWidgetState createState() => _CrearDomiciliariosTiendaWidgetState();
}

class _CrearDomiciliariosTiendaWidgetState extends State<CrearDomiciliariosTiendaWidget> {
  final _tiposVehiculos = ['carro', 'moto', 'bicicleta'];

  List<DomiciliarioModel> _domiciliarios = [];

  @override
  void initState(){ 
    super.initState();
    //_agregarDomiciliario();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> elementosListView = [];
    elementosListView.add(SizedBox(
      height: size.height * 0.03,
    ));
    elementosListView.add(
    Center(
      child: (
        Text(
          'Agregar domiciliarios',
          style: TextStyle(
            color: Colors.black.withOpacity(0.75),
            fontSize: size.width * 0.065,
          ),
        )
      ),
    ));
    elementosListView.add(SizedBox(
      height: size.height * 0.04,
    ));
    _domiciliarios.forEach((domiciliario){
      elementosListView.add(
        _crearModuloDomiciliario(size, domiciliario)
      );
    });
    elementosListView.add(
      SizedBox(
        height: size.height * 0.045,
      )
    );
    elementosListView.add(
      _crearBotonNuevoDomiciliario(size)
    );
    elementosListView.add(
      SizedBox(
        height: size.height * 0.075,
      ),
    );
    return Container(
       child: Container(
         child: ListView(
           children: elementosListView,
         ),
       ),
    );
  }

  Widget _crearModuloDomiciliario(Size size, DomiciliarioModel domiciliario){
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            width: size.width * 0.75,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              border: Border.all(
                width: 1.0,
                color: Colors.black.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(size.width * 0.04),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  blurRadius: size.width * 0.01,
                  spreadRadius: size.width * 0.01,
                  offset: Offset(
                    1.0,
                    1.0
                  ),
                )
              ]
            ),
            child: Column(
              children: _getListaElementosDomiciliario(size, domiciliario),
            ),
          ),
          Container(
            width: size.width * 0.12,
            child: ((_domiciliarios.length > 1)?
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.redAccent.withOpacity(0.9),
              ),
              onPressed: (){
                _eliminarDomiciliario(domiciliario);
              },
            )
            :Container()),
          )
        ],
      ),
    );
  }

  List<Widget> _getListaElementosDomiciliario(Size size, DomiciliarioModel domiciliario){
    return [
      SizedBox(
        height: size.height * 0.02,
      ),
      Text(
        'Elementos domiciliario',
        style: TextStyle(
          color: Colors.black.withOpacity(0.75),
          fontSize: size.width * 0.05,
        ),
      ),
      SizedBox(
        height: size.height * 0.02,
      ),
      //_crearFotoInput(size, domiciliario),
      SizedBox(
        height: size.height * 0.015,
      ),
      _crearInputNombre(size, domiciliario),
      _crearInputEmail(size, domiciliario),
      _crearInputNumeroCelular(size, domiciliario),
      SizedBox(
        height: size.height * 0.018,
      ),
      _crearSelectTipoVehiculo(size, domiciliario),
      _crearInputPlaca(size, domiciliario),
      _crearAdjuntarCopiaCedula(size, domiciliario),
      SizedBox(
        height: size.height * 0.03,
      )
    ];
  }

  Widget _crearInputNombre(Size size, DomiciliarioModel domiciliario){
    return Container(
      height: size.height * 0.072,
      child: TextFormField(
        initialValue: domiciliario.name,
        decoration: InputDecoration(
          hintText: 'Nombre',
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 0.0,
              style: BorderStyle.none
            )
          ),
          icon: Icon(Icons.person),
          //labelText: 'email',

        ),
        onChanged: (String newValue){
          domiciliario.name = newValue;
          print('origin value:');
          print(domiciliario.name);
          
        },
      ),
    );
  }

  Widget _crearInputEmail(Size size, DomiciliarioModel domiciliario){
    return Container(
      height: size.height * 0.072,
      child: TextFormField(
        initialValue: domiciliario.email,
        decoration: InputDecoration(
          hintText: 'Correo',
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 0.0,
              style: BorderStyle.none
            )
          ),
          icon: Icon(Icons.email),
          //labelText: 'email',

        ),
        onChanged: (String newValue){
          domiciliario.email = newValue;
          print('origin value:');
          print(domiciliario.name);
          
        },
      ),
    );
  }

  Widget _crearInputNumeroCelular(Size size, DomiciliarioModel domiciliario){
    return Container(
      height: size.height * 0.072,
      child: TextFormField(
        initialValue: domiciliario.numeroCelular.toString(),
        decoration: InputDecoration(
          suffixText: '(+57)',
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 0.0,
              style: BorderStyle.none
            )
          ),
          icon: Icon(Icons.phone_android),
          //labelText: 'email',

        ),
        onChanged: (String newValue){
          domiciliario.numeroCelular = int.parse(newValue);
          print('origin value:');
          print(domiciliario.name);
          
        },
      ),
    );
  }

  Widget _crearInputPlaca(Size size, DomiciliarioModel domiciliario){
    return Container(
      height: size.height * 0.072,
      child: TextFormField(
        initialValue: domiciliario.placa,
        decoration: InputDecoration(
          hintText: 'Placa',
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 0.0,
              style: BorderStyle.none
            )
          ),
          icon: Icon(Icons.person),
          //labelText: 'email',

        ),
        onChanged: (String newValue){
          domiciliario.placa = newValue;
          print('origin value:');
          print(domiciliario.name);
          
        },
      ),
    );
  }

  /*
  Widget _crearFotoInput(Size size, DomiciliarioModel domiciliario){
    return Container(
      height: size.height * 0.1,
      width: size.width * 0.37,
      child: RaisedButton(
        padding: EdgeInsets.all(0.0),
        elevation: size.width * 0.015,
        color: Colors.black.withOpacity(0.15).withBlue(100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size.width * 0.028)
        ),
        child: ((domiciliario.photo == null)?
        Text(
          'Subir foto',
          style: TextStyle(
            color: Colors.black,
            fontSize: size.width * 0.05
          ),
        )
        :Image.asset(
          domiciliario.foto.path,
          width: size.width * 0.4,
          height: size.height * 0.1,
          fit: BoxFit.fill,
        )),
        onPressed: (){
          _crearDialogSubirImagen(context, size, domiciliario);
        },
      ),
    );
  }

  void _crearDialogSubirImagen(BuildContext context, Size size, DomiciliarioModel domiciliario)async{
    Map<String, File> imagenMap = {};
    await utils.tomarFotoDialog(context, size, imagenMap);
    print('imagenMap:');
    print(imagenMap);
    if(imagenMap['imagen']!= null){
      domiciliario.foto = imagenMap['imagen'];
      setState(() {
        
      });
    }
  }
  */

  Widget _crearSelectTipoVehiculo(Size size, DomiciliarioModel domiciliario){
    
    return Container(
      width: size.width * 0.65,
      margin: EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Tipo de vehiculo',
            style: TextStyle(
              color: Colors.black.withOpacity(0.65),
              fontSize: size.width * 0.04
            ),
          ),

          DropdownButton<String>(
            elevation: 12,
            value: domiciliario.tipoVehiculo,
            items: _tiposVehiculos.map((tipoVehiculo)=>DropdownMenuItem(
              value: tipoVehiculo,
              child: Text(
                tipoVehiculo,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.75),
                  fontSize: size.width * 0.044,
                ),
              ),
            )).toList(),
            onChanged: (String newValue){
              domiciliario.tipoVehiculo = newValue;
              print('domiciliario: ${domiciliario.toJson()}');
              setState(() {
                
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _crearAdjuntarCopiaCedula(Size size, DomiciliarioModel domiciliario){
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            'Adjuntar imagen de cédula',
            style: TextStyle(
              color: Colors.black.withOpacity(0.75),
              fontSize: size.width * 0.041,
            ),
          ),
          SizedBox(
            width: size.width * 0.02,
          ),
          IconButton(
            icon: Icon(
              Icons.file_upload,
              color: Colors.black.withOpacity(0.55),
              size: size.width * 0.058,
            ),
            onPressed: (){
            },
          )
        ],
      ),
    );
  }

  Widget _crearBotonNuevoDomiciliario(Size size){
    return Center(
      //width: size.width * 0.25,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: size.height * 0.01),
        color: Colors.blueGrey.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size.width * 0.045)
        ),
        child: Text(
          'Nuevo horario',
          style: TextStyle(
            color: Colors.black.withOpacity(0.7),
            fontSize: size.width * 0.06,
          ),
        ),
        onPressed: //(_verificarCondicionesAgregarDomiciliario())? _agregarDomiciliario : null,
          (){}
      ),
    );
  }
  /*
  bool _verificarCondicionesAgregarDomiciliario(){

    for(int i = 0; i < _domiciliarios.length; i++){
      DomiciliarioModel domiciliario = _domiciliarios[i];
      print('*****');
      print('domiciliario:');
      print(domiciliario.toJson());
      if(
        domiciliario.nombre == '' 
        //|| domiciliario.foto == null 
        || domiciliario.email == ''
        || domiciliario.numeroCelular == ''
        || domiciliario.placaVehiculo == ''
        //|| domiciliario.cedulaCara1 == null
        //|| domiciliario.cedulaCara2 == null
        )
          return false;
    }
    return true;


  }

  void _agregarDomiciliario(){
    DomiciliarioModel nuevo = new DomiciliarioModel(
      id: _domiciliarios.length,
      nombre: '',
      email: '',
      numeroCelular: '',
      tipoVehiculo: _tiposVehiculos[0],
      placaVehiculo: '',
    );
    _domiciliarios.add(nuevo);
    print('domiciliario: ${nuevo.toJson()}');
    setState(() {
      
    });
  }
  */

  void _eliminarDomiciliario(DomiciliarioModel domiciliario){
    print('domiciliario: ${domiciliario.toJson()}');
    //_domiciliarios.removeWhere((actual)=>actual.id == domiciliario.id);
    List<DomiciliarioModel> nuevosDomiciliarios = [];
    _domiciliarios.forEach((actual){
      if(actual.id != domiciliario.id)
        nuevosDomiciliarios.add(actual);
    });
    //_domiciliarios.remove(domiciliario);
    _domiciliarios = nuevosDomiciliarios;
    setState(() {
      
    });
  }
}