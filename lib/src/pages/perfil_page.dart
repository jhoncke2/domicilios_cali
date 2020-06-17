import 'dart:io';
import 'package:domicilios_cali/src/widgets/bottom_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:domicilios_cali/src/bloc/lugares_bloc.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:domicilios_cali/src/models/lugares_model.dart';
import 'package:domicilios_cali/src/utils/data_prueba/usuarios_prueba.dart';
import 'package:domicilios_cali/src/widgets/mapa_tienda_widget.dart';
import 'package:flutter/material.dart';
class PerfilPage extends StatefulWidget with UsuariosPrueba{
  static final route = 'perfil';

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  ImagePicker _imagePicker = ImagePicker();
  bool _cargando = false;
  File _imagenSeleccionada;

  @override
  Widget build(BuildContext context) {
    UsuarioBloc usuarioBloc = Provider.usuarioBloc(context);   
    LugaresBloc lugaresBloc = Provider.lugaresBloc(context);
    //lugaresBloc.cargarLugares(usuarioBloc.token);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.09),
        children: [
          SizedBox(
            height: size.height * 0.09,
          ),    
          _crearTitulo(size),
          SizedBox(
            height: size.height * 0.02,
          ),
          _crearFoto(size, widget.usuarios[0]['imagen_url']),
          SizedBox(
            height: size.height * 0.035,
          ),
          //_crearDatosPerfil(size, usuarioBloc),
          _crearEspacioDato(size, 'Nombre', usuarioBloc.usuario.name),
          SizedBox(
            height: size.height * 0.02,
          ),
          _crearEspacioDato(size, 'Correo', usuarioBloc.usuario.email),
          SizedBox(
            height: size.height * 0.02,
          ),
          _crearEspacioDato(size, 'Celular', '3133854589'),
          SizedBox(
            height: size.height * 0.02,
          ),
          _crearMapa(size, lugaresBloc),
          SizedBox(
            height: size.height * 0.005
          ),
          _crearCampoHorarios(size, []),
          SizedBox(
            height: size.height * 0.05
          ),
           _crearSolicitarPago(size),
          SizedBox(
            height: size.height * 0.05
          ),
          //_crearBotonCambiarRadio(context, size),
        ],
      ),
      bottomNavigationBar: BottomBarWidget(),
    );
  }

  Widget _crearTitulo(Size size){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          iconSize: size.width * 0.06,
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey.withOpacity(0.8),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        
        Text(
          'Perfil',
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: size.width * 0.075
          ),
        ),
        SizedBox(
          width: size.width * 0.1,
        ),

      ],
    );
  }

  Widget _crearFoto(Size size, String urlFoto){
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
            image: NetworkImage(urlFoto),
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
            color: Colors.black.withOpacity(0.75),
            fontSize: size.width * 0.045
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
              color: Colors.black.withOpacity(0.75),
              fontSize: size.width * 0.041
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearMapa(Size size, LugaresBloc lugaresBloc){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Cobertura de entrega de producto',
          style: TextStyle(
            color: Colors.black.withOpacity(0.75),
            fontSize: size.width * 0.046
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        StreamBuilder(
          stream: lugaresBloc.lugaresStream,
          builder: (BuildContext context, AsyncSnapshot<List<LugarModel>> snapshot){
            if(snapshot.hasData){
              if(snapshot.data != null){
                return MapaTiendaWidget(
                  snapshot.data[0],
                  height: 0.35,
                );
              }
              return Center(
                child: CircularProgressIndicator()
              );
            }
            return Center(
              child: CircularProgressIndicator()
            );
          },
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
            color: Colors.black.withOpacity(0.75),
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
                color: Colors.black.withOpacity(0.75),
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

