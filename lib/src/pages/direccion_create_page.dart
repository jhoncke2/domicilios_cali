import 'package:domicilios_cali/src/bloc/lugares_bloc.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:domicilios_cali/src/models/lugares_model.dart';
import 'package:flutter/material.dart';

import 'package:domicilios_cali/src/utils/google_services.dart' as googleServices;
import 'package:domicilios_cali/src/utils/data_prueba/componentes_lugares.dart' as componentesLugares;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DireccionCreatePage extends StatefulWidget {
  static final route = 'direccion_create';

  @override
  _DireccionCreatePageState createState() => _DireccionCreatePageState();
}

class _DireccionCreatePageState extends State<DireccionCreatePage> {
  LugarModel lugar = LugarModel();

  String _valorDireccion;
  String _dropdownDepartamentoValue;
  String _dropdownCiudadValue;
  String _dropdownTipoDeViaValue;
  String _valorViaPrincipal;
  String _valorViaSecundaria;
  String _valorNumeroDomiciliario;
  
  List<DropdownMenuItem> _itemsCiudades = [];

  @override
  void initState() {
    /*
    _valorDireccion = 'Av. calle 40 # 13 - 73';
    _dropdownDepartamentoValue = 'Bogotá';
    _dropdownCiudadValue = 'Bogotá';
    _dropdownTipoDeViaValue = 'Avenida calle';
    _valorViaPrincipal = '40';
    _valorViaSecundaria = '13';
    _valorNumeroDomiciliario = '73';
    */
    // TODO: implement initState
    super.initState();  
  }

  @override
  Widget build(BuildContext context) {
    final usuarioBloc = Provider.usuarioBloc(context);
    final lugaresBloc = Provider.lugaresBloc(context);
    String token = usuarioBloc.token;
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.12),
          height: size.height,
          width: size.width,
          child: ListView(        
            children: [
              SizedBox(
                height: size.height * 0.045,
              ),
              _crearTitulo(size),
              SizedBox(
                height: size.height * 0.08,
              ),
              _crearFormDirecciones(size, lugaresBloc),
              SizedBox(
                height: size.height * 0.065,
              ),
              _crearBotonCrear(size, lugaresBloc, token),
              SizedBox(
                height: size.height * 0.4,
              ),  
            ]
          ),
        ),
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
          'Crear dirección',
          style: TextStyle(
            fontSize: size.width * 0.067,
            color: Colors.black.withOpacity(0.65)
          ),
        ),
        SizedBox(
          width: size.width * 0.05,
        )
      ],
    );
  }

  Widget _crearFormDirecciones(Size size, LugaresBloc lugaresBloc){    
    return Form(
      child: Column(
        children: [ 
          TextFormField(
            initialValue: _valorDireccion,
            decoration: InputDecoration(
              labelText: 'La dirección como te la sabes',
            ),
            onChanged: (newValue){
              _valorDireccion = newValue;
            },
          ),
          SizedBox(
            height: size.height * 0.045,
          ),
          (_dropdownDepartamentoValue != null)?Text(
            'departamento',
            style: TextStyle(
              fontSize: size.width * 0.038,
              color: Colors.black45,
            ),
          )
          :SizedBox(),
          DropdownButton(
            hint: Text('departamento'),
            
            value: _dropdownDepartamentoValue,
            items: componentesLugares.departamentos.map((departamento){
              return DropdownMenuItem<String>(
                value: departamento['nombre'],
                child: Text(departamento['nombre']),
              );
            }).toList(),
            onChanged: (String value){
              _dropdownDepartamentoValue = value;
              _dropdownCiudadValue = null;
              _itemsCiudades = _generarNombresCiudadesPorDepartamento(value);
              setState(() {
              });
            },
          ),
          SizedBox(
            height: size.height * 0.045,
          ),
          (_dropdownCiudadValue != null)?Text(
            'ciudad',
            style: TextStyle(
              fontSize: size.width * 0.038,
              color: Colors.black45,
            ),
          )
          :SizedBox(),
          DropdownButton(
            hint: Text('ciudad'),
            value: _dropdownCiudadValue,
            items: _itemsCiudades,
            onChanged: (value){
              _dropdownCiudadValue = value;
              setState(() {
                
              });
            },
          ),
          SizedBox(
            height: size.height * 0.045,
          ),
          (_dropdownTipoDeViaValue != null)?Text(
            'tipo de vía',
            style: TextStyle(
              fontSize: size.width * 0.038,
              color: Colors.black45,
            ),
          )
          :SizedBox(),
          DropdownButton(
            hint: Text('tipo de vía'),
            value: _dropdownTipoDeViaValue,
            items: componentesLugares.tipos_vias.map((tipoVia){
              return DropdownMenuItem(
                value: tipoVia,
                child: Text(tipoVia),
              );
            }).toList(),
            onChanged: (value){
              _dropdownTipoDeViaValue = value;
              setState(() {
                
              });
            },
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Column(
            children: [
              TextFormField(
                initialValue: _valorViaPrincipal,
                decoration: InputDecoration(
                  labelText: 'Via principal',
                ),
                onChanged: (newValue){
                  _valorViaPrincipal = newValue;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                '#',
                style: TextStyle(
                  fontSize: size.width * 0.05,
                  color: Colors.black45
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              TextFormField(
                initialValue: _valorViaSecundaria,
                decoration: InputDecoration(
                  labelText: 'Via secundaria',
                ),
                onChanged: (newValue){
                  _valorViaSecundaria = newValue;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                '-',
                style: TextStyle(
                  fontSize: size.width * 0.062,
                  color: Colors.black45
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextFormField(
                initialValue: _valorNumeroDomiciliario,
                decoration: InputDecoration(
                  labelText: 'Num',
                ),
                onChanged: (newValue){
                  _valorNumeroDomiciliario = newValue;
                },
              ),
            ],
          ),
          
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _generarNombresCiudadesPorDepartamento(String nombreDepartamento){
    print(nombreDepartamento);
    dynamic departamento = componentesLugares.departamentos.singleWhere(
      (element) => element['nombre'] == nombreDepartamento
    );
    print(departamento);
    List<DropdownMenuItem<String>> ciudadesItems = [];

    departamento['ciudades'].forEach((ciudad){
      ciudadesItems.add(
        DropdownMenuItem(
          value: ciudad,
          child: Text(
            ciudad,
          ),
        )
      );
    });

    return ciudadesItems;
  }

  void _guardarDatos(LugaresBloc lugaresBloc, String token)async{
    //googleServices.getUbicacionConComponentesDireccion(componentes)
    List<Map<String, dynamic>> componentesLugar = _crearComponentes();
    if(componentesLugar == null)
      return;
    LatLng posicion = await googleServices.getUbicacionConComponentesDireccion(componentesLugar);
    lugar.latitud = posicion.latitude;
    lugar.longitud = posicion.longitude;
    lugar.componentes = componentesLugar;
    lugar.nombre = _valorDireccion;
    lugar.direccion = _valorDireccion;
    lugar.tipoViaPrincipal = _dropdownTipoDeViaValue;
    lugar.elegido = false;
    await lugaresBloc.crearLugar(lugar, token);
    Navigator.pop(context);
  }

  List<Map<String, dynamic>> _crearComponentes(){
    List<Map<String, dynamic>> componentes = [];
    //Lo quité. Estar pendiente.
    //widget.lugar.elegido = false;
    var componente;
    for(int i = 0; i < 6; i++){
      switch(i){
        case 0:
          componente = {
            'nombre':'pais',
            'valor':'Colombia'
          };
          break;
        case 1:
          componente = {
            'nombre':'departamento',
            'valor':_dropdownDepartamentoValue
          };
          break;
        case 2:
          componente = {
            'nombre':'ciudad',
            'valor':_dropdownCiudadValue
          };
          break;
        case 3:
          componente = {
            'nombre':'via_principal',
            'valor':  '$_dropdownTipoDeViaValue $_valorViaPrincipal'
          };
          break;
        case 4:
          componente = {
            'nombre':'via_secundaria',
            'valor':_valorViaSecundaria
          };
          break;
        case 5:
          componente = {
            'nombre':'numero_domiciliario',
            'valor':_valorNumeroDomiciliario
          };
          break;
      }
      if(componente['valor'] == null)
        return null;
      componentes.add(componente);
    }
    return componentes;
  }

  Widget _crearBotonCrear(Size size, LugaresBloc lugaresBloc, String token){
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size.width * 0.04),
      ),
      color: Colors.grey.withOpacity(0.85),
      child: Text(
        'Crear',
        style: TextStyle(
          fontSize: size.width * 0.05,
          color: Colors.black.withOpacity(0.8)
        ),
      ),
      onPressed: (){
        _guardarDatos(lugaresBloc, token);
      },
    );
  }
}