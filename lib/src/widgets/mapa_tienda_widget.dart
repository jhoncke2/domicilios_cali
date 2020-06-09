import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/tienda_bloc.dart';
import 'package:domicilios_cali/src/models/lugares_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MapaTiendaWidget extends StatefulWidget {
  double height;
  LugarModel lugar;
  bool enCreacion;
  MapaTiendaWidget(
    this.lugar,
    {
      this.height = 0.3,
      this.enCreacion = false,
    }
  );
  @override
  _MapaTiendaWidgetState createState() => _MapaTiendaWidgetState();
}

class _MapaTiendaWidgetState extends State<MapaTiendaWidget> {
  GoogleMapController _mapController;
  double _radio = 0;
  Set _circles = Set<Circle>();
  Set _markers = Set<Marker>();

  @override
  Widget build(BuildContext context) {
    //_generarCircles();
    TiendaBloc tiendaBloc = Provider.tiendaBloc(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * widget.height,
      width: size.width,
      child: StreamBuilder(
        stream: tiendaBloc.lugarCreadoStream,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            print('tiene data: ');
            print(snapshot.data);
            LugarModel lugar = snapshot.data;
            _generarMarkers(lugar);
            return Stack(
              children: [          
                GoogleMap(
                  padding: EdgeInsets.only(bottom:size.height * 0.82),
                  initialCameraPosition: CameraPosition(
                    target: lugar.latLng,
                    zoom: 15.5,
                  ),
                  onMapCreated: (GoogleMapController controller){
                    _mapController = controller;
                    setState(() {
                      
                    });
                  },
                  markers: _markers,
                  circles: _circles,
                ),
                    
                Positioned(
                  bottom: size.height * 0.15,
                  left: size.width * 0.15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: size.width * 0.45,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Radio en metros',
                            icon: Icon(Icons.radio_button_checked)
                          ),
                          //initialValue: "100.0",
                          onChanged: (String newValue){
                            _radio = double.parse(newValue);
                          },
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      FlatButton(    
                        color: Colors.teal.withOpacity(0.75),
                        child: Text('Cambiar'),
                        onPressed: (){
                          _generarCircles(lugar, _radio);
                          setState(() {
                            
                          });
                          
                        },
                      )
                    ],
                  ),
                )
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        }
      ),
    );
  }

  void _generarCircles(LugarModel lugar, double radio){
    if(radio == 0)
      return; 
    _circles.clear();
    _circles.add(Circle(
      circleId: CircleId(lugar.id.toString()),
      center: lugar.latLng,
      radius: radio,
      strokeColor: Colors.white.withOpacity(0.0),
      fillColor: Colors.blueAccent.withOpacity(0.25),
    ));
  }

  void _generarMarkers(LugarModel lugar){
    _markers.add(Marker(
      markerId: MarkerId(lugar.id.toString()),
      position: lugar.latLng,
      draggable: true,
      onDragEnd: (LatLng newPosition){ 
        lugar.latitud = newPosition.latitude;
        lugar.longitud = newPosition.longitude;
        setState(() {
          _generarCircles(lugar, _radio);
        });
      }
    ));
  }
}