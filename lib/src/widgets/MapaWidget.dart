import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:domicilios_cali/src/pages/mapa_page.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:domicilios_cali/src/bloc/lugares_bloc.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
//porque existe un problema de nombres entre este paquete y el de google maps services
import 'package:location/location.dart' as location;
import 'package:domicilios_cali/src/models/lugares_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaWidget extends StatefulWidget {
  final _tiposMapas = ['cliente', 'tienda'];
  List<LugarModel> lugares = [];
  String _tipoMapa;
  double height;

  MapaWidget(
    this._tipoMapa,
    {
      this.lugares,
      this.height = 0.3,
    }
  );

  @override
  _MapaWidgetState createState() => _MapaWidgetState();
}
 
class _MapaWidgetState extends State<MapaWidget> {
  final _geoCoding = new GoogleMapsGeocoding(apiKey: 'AIzaSyDg08rC6Ek2BrH69UsVTfUSYLSBusfGQ-Q');

  Set<Marker> _markers = new Set();

  location.LocationData _actualLocation;
  location.Location _locationController = new location.Location();

  GoogleMapController _mapController;
  //Completer<GoogleMapController> _mapControllerCompleter = Completer();
  //datos de prueba
  List<LugarModel> _lugares;
  String _tipoMapa;
  //fin de datos de prueba

  LugarModel elegido;

  /**
   * En el initState ya se ha creado el elemento 'widget'. Si lo trato de llamar en el constructor _MapaWidgetState(),
   * aparece como null, pues aún no ha sido inicializado.
   * 
   */
  @override
  void initState(){
    super.initState();
    _tipoMapa = widget._tipoMapa;
  }

  @override
  Widget build(BuildContext context){
    //_asignarPosicionActual();
    UsuarioBloc usuarioBloc = Provider.usuarioBloc(context);
    LugaresBloc lugaresBloc = Provider.lugaresBloc(context);
    lugaresBloc.cargarLugares(usuarioBloc.token);
    _definirElegido(lugaresBloc);
    /*
    lugaresBloc.elegidoStream.listen((lugarElegido) {
      elegido = lugarElegido;
      if(_mapController != null){
        _agregarMaker(elegido);
        _mapController.moveCamera(CameraUpdate.newLatLng(
          elegido.latLng
        ));
        
      }
      print(lugarElegido);
    });
    */
    /*
    lugaresBloc.lugaresStream.listen((data) {
      print('*********************');
      print('lugares:');
      print(data);
      if(_mapController != null){
        if(data != null && data.length > 0){
          _mapController.moveCamera(CameraUpdate.newLatLng(
            data.singleWhere((element) => element.elegido).latLng
          ));
        }
        
      }
    });
    */
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Stack(
        children: [
          Container(
            height: size.height * widget.height,
            width: size.width,
            child: GoogleMap(
              mapType: MapType.normal,
              scrollGesturesEnabled: false,
              initialCameraPosition: CameraPosition(
                target: (elegido!=null)?elegido.latLng: LatLng(0.0,0.0),
                zoom: 14.5,
              ),
              onMapCreated: (GoogleMapController newController){
                _mapController = newController;
              },
              markers: _markers,
              onTap: (LatLng tapedPosiion){
                Navigator.of(context).pushNamed(MapaPage.route, arguments: elegido);
              },
              //circles: (_tipoMapa==widget._tiposMapas[1])? _circles : [],
              //circles: null,
              //no sé para qué sirve y/o qué cambia
              //myLocationEnabled: true,
            ),
          ),

          
          Container(
            margin: EdgeInsets.only(top:size.height*0.24, left: size.width * 0.3),
            //child: _crearDropDownButton(size),
            child: _crearBotonCambiarDireccion(size),
          ),
        ],
      ),
    );
  }

  void _definirElegido(LugaresBloc lugaresBloc)async{
    elegido = await lugaresBloc.elegidoStream.last;
  }

  Marker _agregarMaker(LugarModel lugar){
    _markers.add(
      Marker(
        markerId: MarkerId('lugar_${lugar.id}'),
        infoWindow: InfoWindow(
          title: lugar.nombre,
          //snippet: lugar.nombre,
        ),
        position: lugar.latLng,
        icon: BitmapDescriptor.defaultMarker,
      )
    );
  }

  FlatButton _crearBotonCambiarDireccion(Size size){
    return FlatButton(
      child: Text(
        'Cambiar ubicación',
        style: TextStyle(
          color: Color.fromRGBO(80, 80, 80, 1),
          fontSize: size.width * 0.03
        ),
      ),
      onPressed: (){
      },
    );
  }

  void _actualizarMapaAActualLocation() async{
    _actualLocation = await _locationController.getLocation();
    LatLng newPosition = LatLng(_actualLocation.latitude, _actualLocation.longitude);
    setState(() {
      _markers.removeWhere((Marker marker) => marker.markerId == MarkerId('posicion_actual'));
      _markers.add(Marker(
          markerId: MarkerId('posicion_actual'),
          infoWindow: InfoWindow(title: 'mi posición'),
          position: newPosition,
          icon: BitmapDescriptor.defaultMarker,
        )
      );
    });
    
    _mapController.moveCamera(CameraUpdate.newLatLng(newPosition));
  }

  /*
    StreamBuilder(
      stream: lugaresBloc.lugaresStream,
      builder: (BuildContext context, AsyncSnapshot<List<LugarModel>> snapshot){
        if(snapshot.hasData){
          print(snapshot.data);
          LugarModel elegido = snapshot.data.singleWhere((element) => element.elegido);
          if(elegido.latitud != null && elegido.longitud != null){
            _markers.add(_crearMaker(elegido));               
            return Container(
              height: size.height * widget.height,
              width: size.width,
              child: GoogleMap(
                mapType: MapType.normal,
                scrollGesturesEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: elegido.latLng??LatLng(0.0,0.0),
                  zoom: 14.5,
                ),
                onMapCreated: (GoogleMapController newController){
                  _mapController = newController;
                  _mapController.moveCamera(CameraUpdate.newLatLng(elegido.latLng));
                },
                markers: _markers,
                onTap: (LatLng tapedPosiion){
                  Navigator.of(context).pushNamed(MapaPage.route, arguments: elegido);
                },
                //circles: (_tipoMapa==widget._tiposMapas[1])? _circles : [],
                //circles: null,
                //no sé para qué sirve y/o qué cambia
                //myLocationEnabled: true,
              ),
            );
          }
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        
      }
    ),
  */
}