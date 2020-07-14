import 'package:domicilios_cali/src/bloc/lugares_bloc.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:domicilios_cali/src/models/lugares_model.dart';
import 'package:domicilios_cali/src/pages/home_page.dart';
import 'package:domicilios_cali/src/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MapaTiendaWidget extends StatefulWidget {
  static final route = 'direccion_create_mapa';
  @override
  _MapaTiendaWidgetState createState() => _MapaTiendaWidgetState();
}

class _MapaTiendaWidgetState extends State<MapaTiendaWidget> {
  GoogleMapController _mapController;
  LugarModel _lugar;
  Set<Marker> _markers = {};
  bool _ubicacionCambio = false;

  @override
  Widget build(BuildContext context) {
    UsuarioBloc usuarioBloc = Provider.usuarioBloc(context);
    LugaresBloc lugaresBloc = Provider.lugaresBloc(context);
    String token = usuarioBloc.token;

    _crearLugarYMarkers(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _crearElementos(context, size),
      floatingActionButton: _crearBotonSubmit(context, size, lugaresBloc, token),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _crearElementos(BuildContext context, Size size){
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.062,
          ),
          HeaderWidget(),
          SizedBox(
            height: size.height * 0.015,
          ),
          _crearTitulo(context, size),
          SizedBox(
            height: size.height * 0.035,
          ),
          _crearMapa(size),
        ],
      ),
    );
  }

  Widget _crearTitulo(BuildContext context, Size size){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon( 
            Icons.place,
            color: Colors.black.withOpacity(0.8),
            size: size.width * 0.065,
          ),
        SizedBox(
          width: size.width * 0.03,
        ),
        Text(
          'Verifica tu dirección',
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: size.width * 0.055,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }

  Widget _crearMapa(Size size){
    return Container(
      width: size.width,
      height: size.height * 0.63,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            blurRadius: 2.0,
            spreadRadius: size.width * 0.005,
            offset: Offset(
              1.0,
              size.height * 0.045
            )
          )
        ]
      ),
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _lugar.latLng,
          zoom: 14.5,
        ),
        onMapCreated: (GoogleMapController newController){
          _mapController = newController;
        },
        markers: _markers,
        //circles: (_tipoMapa==widget._tiposMapas[1])? _circles : [],
        //circles: null,
        //no sé para qué sirve y/o qué cambia
        //myLocationEnabled: true,
      ),
    );
  }

  Widget _crearBotonSubmit(BuildContext context, Size size, LugaresBloc lugaresBloc, String token){
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
        'Confirmar',
        style: TextStyle(
          fontSize: size.width * 0.05,
          color: Colors.black.withOpacity(0.8)
        ),
      ),
      onPressed: (){
        _guardarDatos(context, lugaresBloc, token);
      },
    );
  }

  void _crearLugarYMarkers(BuildContext context){
    _lugar = ModalRoute.of(context).settings.arguments;
    _markers.add(Marker(
      markerId: MarkerId(_lugar.id.toString()),
      position: _lugar.latLng,
      draggable: true,
      onDragEnd: (LatLng newPosition){
        _ubicacionCambio = true;
        _lugar.latitud = newPosition.latitude;
        _lugar.longitud = newPosition.longitude;
      },
      infoWindow: InfoWindow(
        title: _lugar.direccion
      ),
    ));
  }

  void _guardarDatos(BuildContext context, LugaresBloc lugaresBloc, String token)async{
    if(_ubicacionCambio){
       Map<String, dynamic> response = await lugaresBloc.latLong(_lugar.id, token, _lugar.latitud, _lugar.longitud);
      if(response['status'] == 'ok')
        Navigator.of(context).pushReplacementNamed(HomePage.route);
    }else{
      Navigator.of(context).pushReplacementNamed(HomePage.route);
    }        
  }


}