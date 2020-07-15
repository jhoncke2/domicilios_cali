import 'dart:io';
import 'package:domicilios_cali/src/models/horarios_model.dart';
import 'package:flutter/material.dart';

import 'package:domicilios_cali/src/bloc/tienda_bloc.dart';
import 'package:domicilios_cali/src/widgets/bottom_bar_widget.dart';
import 'package:domicilios_cali/src/widgets/header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:domicilios_cali/src/models/lugares_model.dart';
import 'package:domicilios_cali/src/utils/data_prueba/usuarios_prueba.dart';
import 'package:domicilios_cali/src/utils/data_prueba/datos_tienda_prueba.dart' as datosTiendaPrueba;
class PerfilPage extends StatefulWidget with UsuariosPrueba{
  static final route = 'perfil';
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  //en creación de tienda
  File avatar;
  String _urlAvatar;
  //fin de en creación de tienda

  GoogleMapController _mapController;
  List<String> _listviewHoraItems = [];

  //prueba
  LugarModel direccionTiendaPrueba;
  
  @override
  void initState() {
    direccionTiendaPrueba = LugarModel(
      pais: 'Colombia',
      ciudad: 'Bogotá',
      direccion: 'Avenida calle 40 # 13 - 73',
      observaciones: '',
      tipo: 'tienda',
      rango: 150,
      latitud: -70.5,
      longitud: 35.05
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    UsuarioBloc usuarioBloc = Provider.usuarioBloc(context);
    String token = usuarioBloc.token;
    TiendaBloc tiendaBloc = Provider.tiendaBloc(context);
    tiendaBloc.cargarTienda(token);
    //lugaresBloc.cargarLugares(usuarioBloc.token);
    Size size = MediaQuery.of(context).size;
    if(_listviewHoraItems.length == 0)
      _generarStringItemsHoras(size);
    return Scaffold(
      body: _crearElementos(size, usuarioBloc, tiendaBloc, token),
      bottomNavigationBar: BottomBarWidget(),
    );
  }

  Widget _crearElementos(Size size, UsuarioBloc usuarioBloc, TiendaBloc tiendaBloc, String token){
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:size.width * 0.05),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.065,
            ),
            HeaderWidget(),
            StreamBuilder(
              stream: tiendaBloc.tiendaStream,
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.hasData){
                  List<Widget> listViewItems = [];
                  _agregarItemsCliente(size, usuarioBloc, tiendaBloc, listViewItems);
                  if(snapshot.data != null && snapshot.data.id != null)          
                    _agregarItemsTienda(size, tiendaBloc, listViewItems, snapshot.data.direccion);
                  else if(tiendaBloc.enCreacion)
                    _agregarItemsTienda(size, tiendaBloc, listViewItems, tiendaBloc.direccionTienda);
                  listViewItems.add(
                    Center(
                      child: _crearBotonSubmit(size, tiendaBloc, token),
                    )
                  );
                  return Container(
                    padding: EdgeInsets.all(0),
                    height: size.height * 0.75,
                    child: ListView(
                      padding: EdgeInsets.symmetric(vertical:size.height * 0.02),
                      children: listViewItems,
                    ),
                  );
                }else{
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _agregarItemsCliente(Size size, UsuarioBloc usuarioBloc, TiendaBloc tiendaBloc, List<Widget> items){
    items.add(
      _crearTitulo(size)
    );
    items.add(
      SizedBox(
        height: size.height * 0.02,
      )
    );
    items.add(
      _crearFoto(size, tiendaBloc),
    );
    items.add(
      _crearEspacioDato(size, 'Nombre', usuarioBloc.usuario.name)
    );
    items.add(
      SizedBox(
        height: size.height * 0.02,
      )
    );
    items.add(
      _crearEspacioDato(size, 'Correo', usuarioBloc.usuario.email)
    );
    items.add(
      SizedBox(
        height: size.height * 0.02,
      )
    );
    items.add(
      _crearEspacioDato(size, 'Celular', usuarioBloc.usuario.phone)
    );
    items.add(
      SizedBox(
        height: size.height * 0.025,
      )
    );
  }

  void _agregarItemsTienda(Size size, TiendaBloc tiendaBloc, List<Widget> items, LugarModel direccionTienda){      
    items.add(
      _crearMapa(size, direccionTienda),
    );
    items.add(
      SizedBox(
        height: size.height * 0.035
      ),
    );
    items.add(
      _crearCampoHorarios(size, tiendaBloc),
    );
    items.add(
      SizedBox(
        height: size.height * 0.05
      ),
    );
    items.add(
      _crearAdjuntarImagen(size, tiendaBloc, 'copia de cédula')
    );
    items.add(
      SizedBox(
        height: size.height * 0.01
      ),
    );
    items.add(
      Text(
        'Solicitar pago',
        style: TextStyle(
          color: Colors.black.withOpacity(0.8),
          fontSize: size.width * 0.044
        ),
      ),
    );
    items.add(
      _crearSolicitarPago(size, tiendaBloc),
    );
    items.add(
      SizedBox(
        height: size.height * 0.025,
      )
    ); 
  }

  Widget _crearTitulo(Size size){
    return Center(
      child: Text(
        'Perfil',
        style: TextStyle(
          color: Colors.black.withOpacity(0.8),
          fontWeight: FontWeight.bold,
          fontSize: size.width * 0.07
        ),
      ),
    );
  }

  Widget _crearFoto(Size size, TiendaBloc tiendaBloc){
    //aún falta completar
    Widget imagenWidget;

    return Container(
      padding: EdgeInsets.symmetric(horizontal:size.width * 0.22),
      width: size.width * 0.25,
      child: FlatButton(
        color: Colors.redAccent.withOpacity(0.0),
        child: ClipOval(
          child: FadeInImage(
            width: size.width * 0.45,
            height: size.height * 0.15,
            fit: BoxFit.fill,
            image: (_urlAvatar != null)? NetworkImage(_urlAvatar) : AssetImage('assets/placeholder_images/user.png'),
            placeholder: AssetImage('assets/placeholder_images/user.png'),
          ),
        ),
        onPressed: (){
          
        },
      ),
    );
  }
  
  Widget _crearEspacioDato(Size size, String nombreDato, String dato){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          nombreDato,
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: size.width * 0.045,
            fontWeight: FontWeight.normal
          ),
        ),
        SizedBox(
          height: size.height * 0.005,
        ),
        Container(
          width: size.width * 0.8,
          padding: EdgeInsets.symmetric(vertical: size.height * 0.005, horizontal: size.width * 0.035),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.15),
            borderRadius: BorderRadius.circular(size.width * 0.085)
          ),
          child: Text(
            dato,
            style: TextStyle(
              color: Colors.black.withOpacity(0.55),
              fontSize: size.width * 0.041,
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearMapa(Size size, LugarModel lugarTienda){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Cobertura de entrega de producto',
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: size.width * 0.046
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Container(
          //width: size.width * 0.75,
          height: size.height * 0.45,
          child: GoogleMap(
            scrollGesturesEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: lugarTienda.latLng,
              zoom: 15.0
            ),
            markers: {
              Marker(
                markerId: MarkerId('0'),
                position: lugarTienda.latLng,

              )
            },
            circles: {
              Circle(
                circleId: CircleId('0'),
                radius: lugarTienda.rango.toDouble(),
                center: lugarTienda.latLng,
                fillColor: Colors.blueAccent.withOpacity(0.35),
                strokeColor: Colors.blueAccent.withOpacity(0.5),
                strokeWidth: 1
              )
            },
            onMapCreated: (GoogleMapController newController){
              _mapController = newController;
            },
          ),
        ),
      ],
    );
  }

  Widget _crearCampoHorarios(Size size, TiendaBloc tiendaBloc){
    List<Widget> horariosDiasItems = [];
    horariosDiasItems.add(
      Text(
        'Horario de venta',
        style: TextStyle(
          color: Colors.black.withOpacity(0.8),
          fontSize: size.width * 0.046
        ),
      )
    );
    for(int i = 0; i < 8; i++){
      horariosDiasItems.add(
        _crearHorarioDia(size, tiendaBloc, i)
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: horariosDiasItems,
    );
  }

  Widget _crearHorarioDia(Size size, TiendaBloc tiendaBloc, int diaIndex){
    HorarioModel horarioTienda = tiendaBloc.horarioTienda;
    String horaInicio;
    String horaFin;
    String dia;
    switch(diaIndex){
      case 0:
        horaInicio = horarioTienda.lunesInicio;
        horaFin = horarioTienda.lunesFinal;
        dia = 'lunes';
        break;
      case 1:
        horaInicio = horarioTienda.martesInicio;
        horaFin = horarioTienda.martesFinal;
        dia = 'martes';
        break;
      case 2:
        horaInicio = horarioTienda.miercolesInicio;
        horaFin = horarioTienda.miercolesFinal;
        dia = 'miércoles';
        break;
      case 3:
        horaInicio = horarioTienda.juevesInicio;
        horaFin = horarioTienda.juevesFinal;
        dia = 'jueves';
        break;
      case 4:
        horaInicio = horarioTienda.viernesInicio;
        horaFin = horarioTienda.viernesFinal;
        dia = 'viernes';
        break;
      case 5:
        horaInicio = horarioTienda.sabadoInicio;
        horaFin = horarioTienda.sabadoFinal;
        dia = 'sábado';
        break;
      case 6:
        horaInicio = horarioTienda.domingoInicio;
        horaFin = horarioTienda.domingoFinal;
        dia = 'domingo';
        break;
      case 7:
        horaInicio = horarioTienda.festivosInicio;
        horaFin = horarioTienda.festivosFinal;
        dia = 'festivos';
        break;
    }
    
    return Container(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.0075),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: size.width * 0.26,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ((horaInicio == null || horaFin == null)?
                  Container(
                    width: size.width * 0.07,
                    height: size.height * 0.026,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1,
                        color: Colors.black.withOpacity(0.9)
                      )
                    ),
                    
                  )
                  : Icon(
                    Icons.check_circle_outline,
                    color: Color.fromRGBO(192, 214, 81, 1),
                    size: size.width * 0.068,
                  )
                ),
                
                SizedBox(
                  width: size.width * 0.01,
                ),
                Text(
                  dia,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: size.width * 0.038
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(
            width: size.width * 0.001,
          ),
          Text(
            ' de ',
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: size.width * 0.038
            ),
          ),
          _crearPopUpHora(size, tiendaBloc, horarioTienda, diaIndex, 'hora_inicio', horaInicio),
          Text(
            ' a ',
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: size.width * 0.038
            ),
          ),
          _crearPopUpHora(size, tiendaBloc, horarioTienda, diaIndex, 'hora_fin', horaFin),
        ],
      ),
    );
  }

  /**
   * *params:
   *    * tipoHora: <"hora_inicio" | "hora_fin">
   *      
   */
  Widget _crearPopUpHora(Size size, TiendaBloc tiendaBloc, HorarioModel horarioTienda, int diaIndex, String tipoHora, String hora){
    List<PopupMenuEntry<int>> popUpItems = [
      PopupMenuItem<int>(
        value: 0,
        height: size.height * 0.08,
        child: _crearListViewHora(size, tiendaBloc, horarioTienda, diaIndex, tipoHora),
        enabled: false,
      )
    ];
    return PopupMenuButton<int>(
      onSelected: (int newValue){
        setState(() {
          
        });
      },
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      itemBuilder: (BuildContext context){
        return popUpItems;
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size.width * 0.02)
      ),
      offset: Offset(
        -size.width * 0.01,
        size.height * -0.1,
      ),
      child: Container(
        width: size.width * 0.265,
        height: size.height * 0.032,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.width * 0.04),
          color: Colors.grey.withOpacity(0.2)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: size.width * 0.02
            ),
            ((hora != null)?
            Text( 
             hora,
              style: TextStyle(
                fontSize: size.width * 0.03,
                color: Colors.black.withOpacity(0.8)
              ),
            )
            :SizedBox(width: size.width * 0.05)
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.grey.withOpacity(0.9),
              size: size.width * 0.079,
            ),
          ],
        ),
      ),
    );
  }
  /**
   * *params:
   *    * tipoHora: <"hora_inicio" | "hora_fin">
   *      
   */
  Widget _crearListViewHora(Size size, TiendaBloc tiendaBloc, HorarioModel horarioTienda, int diaIndex, String tipoHora){
    return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(0),
      height: size.height * 0.075,
      width: size.width * 0.19,
      child: ListView(
        padding: EdgeInsets.all(0.0),
        scrollDirection: Axis.vertical,
        children: _listviewHoraItems.map((String hora){
          return Container(
            height: size.height * 0.029,
            child: FlatButton(
              padding: EdgeInsets.symmetric(horizontal:0, vertical: size.height * 0.004),
              child: Text(
                hora,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: size.width * 0.032
                ),
              ),
              onPressed: (){
                _guardarHorariosPorIndex(tiendaBloc, horarioTienda, diaIndex, hora, tipoHora);
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  void _guardarHorariosPorIndex(TiendaBloc tiendaBloc, HorarioModel horarioTienda, int index, String hora, String tipoHora){
    switch(index){
      case 0:
        if(tipoHora == 'hora_inicio')
          horarioTienda.lunesInicio = hora  ;
        else
          horarioTienda.lunesFinal = hora ;
        break;
      case 1:
        if(tipoHora == 'hora_inicio')
          horarioTienda.martesInicio = hora ;
        else
          horarioTienda.martesFinal = hora  ;
        break;
      case 2:
        if(tipoHora == 'hora_inicio')
          horarioTienda.miercolesInicio = hora  ;
        else
          horarioTienda.miercolesFinal = hora ;
        break;
      case 3:
        if(tipoHora == 'hora_inicio')
          horarioTienda.juevesInicio = hora ;
        else
          horarioTienda.juevesFinal = hora  ;
        break;
      case 4:
        if(tipoHora == 'hora_inicio')
          horarioTienda.viernesInicio = hora  ;
        else
          horarioTienda.viernesFinal = hora ;
        break;
      case 5:
        if(tipoHora == 'hora_inicio')
          horarioTienda.sabadoInicio = hora ;
        else
          horarioTienda.sabadoFinal = hora  ;
        break;
      case 6:
        if(tipoHora == 'hora_inicio')
          horarioTienda.domingoInicio = hora  ;
        else
          horarioTienda.domingoFinal = hora ;
        break;
      case 7:
        if(tipoHora == 'hora_inicio')
          horarioTienda.festivosInicio = hora ;
        else
          horarioTienda.festivosFinal = hora  ;
        break;
    }
    setState(() {
      Navigator.of(context).pop();
    });
  }

  Widget _crearSolicitarPago(Size size, TiendaBloc tiendaBloc){
    return Container(
      width: size.width * 0.45,
      padding: EdgeInsets.only(left: size.width * 0.07),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _crearInputTienda(size, tiendaBloc, 'banco'),
          SizedBox(
            height: size.height * 0.015,
          ),
          _crearInputTienda(size, tiendaBloc, 'tipo de cuenta'),
          SizedBox(
            height: size.height * 0.015,
          ),
          _crearInputTienda(size, tiendaBloc, 'Número de cuenta'),
          SizedBox(
            height: size.height * 0.015,
          ),
          _crearAdjuntarImagen(size, tiendaBloc, 'certificación bancaria')
        ],
      ),
    );
  }

  Widget _crearInputTienda(Size size, TiendaBloc tiendaBloc, String tipoInput){
    List<String> elementosPopUp;
    Widget input;
    switch(tipoInput){
      case 'banco':
        elementosPopUp = datosTiendaPrueba.bancos;
        input = _crearPopUp(size, tiendaBloc, elementosPopUp, tipoInput);
        break;
      case 'tipo de cuenta':
        elementosPopUp = datosTiendaPrueba.tiposDeCuenta;
        input = _crearPopUp(size, tiendaBloc, elementosPopUp, tipoInput);
        break;
      case 'Número de cuenta':
        input = _crearInputNumeroDeCuenta(size, tiendaBloc);
        break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          tipoInput,
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: size.width * 0.04
          ),
        ),
        input,
      ],
    );
  }


  Widget _crearPopUp(Size size, TiendaBloc tiendaBloc, List<String> elementos, String tipoPopUp){
    final elementoElegido = (tipoPopUp == 'banco')? 
    tiendaBloc.tienda.banco
    : tiendaBloc.tienda.tipoDeCuenta;
    List<PopupMenuEntry<String>> popupItems = [];
    elementos.forEach((String elemento){
      popupItems.add(
        PopupMenuItem(
          value: elemento,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: size.width * 0.095,
                height: size.height * 0.03,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: ((elemento != elementoElegido)? 
                    Border.all(
                      width: 1,
                      color: Colors.black.withOpacity(0.9)
                    )
                    :null
                  ),
                  color: (elemento == elementoElegido)? Color.fromRGBO(192, 214, 81, 1) : Colors.white,
                ),
              ),
              SizedBox(
                width: size.width * 0.025,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width  * 0.45),
                child: Text(
                  elemento,
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        )
      );
    });
    return PopupMenuButton<String>(
      onSelected: (String selected){
        if(tipoPopUp == 'banco')
          tiendaBloc.tienda.banco = selected;
        else
          tiendaBloc.tienda.tipoDeCuenta = selected;
        setState(() {

        });
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size.width * 0.048)
      ),
      offset: Offset(
        -size.width * 0.04,
        size.height * 0.155,
      ),
      padding: EdgeInsets.all(0.0),
      child: Container(
        width: size.width * 0.45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.width * 0.04),
          color: Colors.grey.withOpacity(0.2)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: size.width * 0.02
            ),
            ((elementoElegido != null)?
            Text( 
             elementoElegido,
              style: TextStyle(
                fontSize: size.width * 0.04,
                color: Colors.black.withOpacity(0.8)
              ),
            )
            :SizedBox(width: size.width * 0.08)
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.grey.withOpacity(0.65),
              size: size.width * 0.085,
            ),
          ],
        ),
      ),
      itemBuilder: (BuildContext context){
        return popupItems;
      },
    ); 
  }

  Widget _crearInputNumeroDeCuenta(Size size, TiendaBloc tiendaBloc){
    return Container(
      width: size.width * 0.45,
      height: size.height * 0.047,
      child: TextField(
        style: TextStyle(
          color: Colors.black
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: size.height * 0.0025,
            horizontal: size.width * 0.025
          ),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.25),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.001,
              color: Colors.green.withOpacity(0.9),
            ),
              borderRadius: BorderRadius.circular(
              size.width * 0.1
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red.withOpacity(0.85),
              width: size.width * 0.0001
            ),
            borderRadius: BorderRadius.circular(
              size.width * 0.1
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red.withOpacity(0.85),
              width: size.width * 0.0001
            ),
            borderRadius: BorderRadius.circular(
              size.width * 0.1
            ),
          )
        ),
        onChanged: (String newValue){
          tiendaBloc.tienda.numeroDeCuenta = newValue;
          setState(() {
            
          });
        },
      ),
    );
  }

  Widget _crearAdjuntarCertificacionBancaria(Size size, TiendaBloc tiendaBloc){
    return Container(
      padding: EdgeInsets.only(left: size.width * 0.075),
      child: Row(
        children: <Widget>[
          Text(
            'Adjuntar certificación bancaria',
            style: TextStyle(
              fontSize: size.width * 0.04,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
          SizedBox(
            width: size.width * 0.025,
          ),
          Icon(
            Icons.insert_drive_file,
            color: Colors.grey.withOpacity(0.8),
            size: size.width * 0.085,
          )
        ],
      ),
    );
  }

  Widget _crearAdjuntarImagen(Size size, TiendaBloc tiendaBloc, String tipoImagen){
    return Row(
      children: <Widget>[
        Text(
          'Adjuntar $tipoImagen',
          style: TextStyle(
            fontSize: size.width * 0.04,
            color: Colors.black.withOpacity(0.8),
          ),
        ),
        SizedBox(
          width: size.width * 0.025,
        ),
        IconButton(
          icon: Icon(
            Icons.insert_drive_file,
            color: Colors.grey.withOpacity(0.8),
            size: size.width * 0.085,
          ),
          onPressed: (){
          },
        )
      ],
    );
  }

  Widget _crearBotonSubmit(Size size, TiendaBloc tiendaBloc, String token){
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size.width * 0.04),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.045,
        vertical: size.height * 0.002
      ),
      color: Colors.grey.withOpacity(0.62),
      child: Text(
        'Aceptar',
        style: TextStyle(
          fontSize: size.width * 0.05,
          color: Colors.black.withOpacity(0.8)
        ),
      ),
      onPressed: (){
        _guardarDatos(tiendaBloc, token);
      },
    );
  }

  void _guardarDatos(TiendaBloc tiendaBloc, String token){
    
  }

  void _generarStringItemsHoras(Size size){
    for(int i = 0; i < 24; i++){
      String horaString = ((i == 0)? '$i$i  :  00'
      : (i==12)? '$i  :  00' 
      : (i < 10)? '0${i%12}  :  00'
      : '${i%12}  :  00');
      horaString += ((i<12)? ' Am' : ' Pm');
      _listviewHoraItems.add(
          horaString
      );
    }

  }

}

