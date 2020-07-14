import 'package:domicilios_cali/src/bloc/tienda_bloc.dart';
import 'package:domicilios_cali/src/widgets/bottom_bar_widget.dart';
import 'package:domicilios_cali/src/widgets/header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:domicilios_cali/src/models/lugares_model.dart';
import 'package:domicilios_cali/src/utils/data_prueba/usuarios_prueba.dart';
import 'package:flutter/material.dart';
class PerfilPage extends StatefulWidget with UsuariosPrueba{
  static final route = 'perfil';
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  GoogleMapController _mapController;

  String _urlAvatar;

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
    TiendaBloc tiendaBloc = Provider.tiendaBloc(context);
    tiendaBloc.cargarTienda(usuarioBloc.token);
    //lugaresBloc.cargarLugares(usuarioBloc.token);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _crearElementos(size, usuarioBloc, tiendaBloc),
      bottomNavigationBar: BottomBarWidget(),
    );
  }

  Widget _crearElementos(Size size, UsuarioBloc usuarioBloc, TiendaBloc tiendaBloc){
    List<Widget> listViewItems = [];
    _agregarItemsCliente(size, usuarioBloc, listViewItems);

    return Container(
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
                if(snapshot.data != null && snapshot.data.id != null)
                  _agregarItemsTienda(size, listViewItems, direccionTiendaPrueba);
                else if(tiendaBloc.enCreacion)
                  _agregarItemsTienda(size, listViewItems, tiendaBloc.direccionTienda);
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
    );
  }

  void _agregarItemsCliente(Size size, UsuarioBloc usuarioBloc, List<Widget> items){
    items.add(
      _crearTitulo(size)
    );
    items.add(
      SizedBox(
        height: size.height * 0.02,
      )
    );
    items.add(
      _crearFoto(size),
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
  }

  void _agregarItemsTienda(Size size, List<Widget> items, LugarModel direccionTienda){      
    items.add(
      _crearMapa(size, direccionTienda),
    );
    items.add(
      SizedBox(
        height: size.height * 0.035
      ),
    );
    items.add(
      _crearCampoHorarios(size, []),
    );
    items.add(
      SizedBox(
        height: size.height * 0.05
      ),
    );
    items.add(
      _crearSolicitarPago(size),
    );
  }

  Widget _crearDatosPerfilBasicos(Size size){
    return Column(

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

  Widget _crearFoto(Size size){
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
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: lugarTienda.latLng,
              zoom: 15.0
            ),
            circles: {
              Circle(
                circleId: CircleId('0'),
                radius: 450.0,
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

  Widget _crearCampoHorarios(Size size, List<Map<String, dynamic>> horarios){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Horarios',
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: size.width * 0.046
          ),
        ),
      ],
    );
  }

  Widget _crearSolicitarPago(Size size){
    return Container(
      width: size.width * 0.45,
      child: FlatButton(
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        child: Row(
          children: <Widget>[
            Text(
              'Solicitar pago',
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: size.width * 0.044
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.black.withOpacity(0.6),
              size: size.width * 0.05,
            ),
          ],
        ),
        onPressed: (){

        },
      ),
    );
  }

}

