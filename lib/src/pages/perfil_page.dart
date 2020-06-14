import 'dart:io';
import 'package:domicilios_cali/src/widgets/bottom_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:domicilios_cali/src/bloc/lugares_bloc.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:domicilios_cali/src/models/lugares_model.dart';
import 'package:domicilios_cali/src/utils/data_prueba/usuarios_prueba.dart';
import 'package:domicilios_cali/src/widgets/DrawerWidget.dart';
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
      body: Column(
        children: [
          _crearDatosPerfil(size, usuarioBloc),
          SizedBox(
            height: size.height * 0.04,
          ),
          _crearMapa(lugaresBloc),
          SizedBox(
            height: size.height * 0.005
          ),
          _crearBotonCambiarRadio(context, size),
        ],
      ),
      bottomNavigationBar: BottomBarWidget(),
    );
  }

  Widget _crearDatosPerfil(Size size, UsuarioBloc usuarioBloc){
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.01,
        ),      
        Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black45,
                blurRadius: 15.0,
                offset: Offset(
                  6.0,
                  6.0
                ),
              )
            ],
          ),
          child: Stack(
            children: [
              FadeInImage(
                //height: size.width * 0.55,
                width: size.width * 0.75,
                image: NetworkImage(widget.usuarios[0]['imagen_url']),
                placeholder: AssetImage('assets/placeholder_images/user.png'),
              ),
              Container(
                margin: EdgeInsets.only(left: size.width * 0.62, top: size.width * 0.43),
                child: IconButton(
                  iconSize: size.width * 0.1,
                  color: Colors.white.withOpacity(0.4),
                  icon: Icon(Icons.image),
                  onPressed: ()=>_crearImagenDialog(context, usuarioBloc, size),
                ),
              )
            ],
          ),
        ),
         SizedBox(
          height: size.height * 0.015
        ),
        Text(
          widget.usuarios[0]['name'],
          style: TextStyle(
            fontSize: size.width * 0.065,
            color: Colors.black.withOpacity(0.7)
          ),
        ),

      ],
    );
  }

  Widget _crearMapa(LugaresBloc lugaresBloc){
    return StreamBuilder(
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
    );
  }

  Widget _crearBotonCambiarRadio(BuildContext context, Size size){
    return RaisedButton(
      child: Text(
        'Cambiar radio',
        style: TextStyle(
          fontSize: size.width * 0.055,
          color: Colors.white54
        ),
      ),
      color: Theme.of(context).secondaryHeaderColor,
      onPressed: (){

      },
    );
  }

  void _elegirFoto(){

  }


  void _crearImagenDialog(BuildContext context,UsuarioBloc usuarioBloc, Size size){
    showDialog(
      context: context,
      builder: (BuildContext buildContext){
        return Dialog(
          child: Container(
            color: Colors.grey.withOpacity(0.35),
            padding: EdgeInsets.symmetric(vertical:0.0),
            height: size.height * 0.24,
            width: size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.grey.withOpacity(0.35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.redAccent.withOpacity(0.65),
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                CupertinoButton(
                  borderRadius: BorderRadius.all(Radius.circular(0.0)),
                  //color: Colors.cyanAccent.withOpacity(0.2),
                  child: Text(
                    'Subir imagen',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.45),
                      fontSize: size.width * 0.049
                    ),
                  ),
                  onPressed: ()=>_procesarImagen(context, usuarioBloc, ImageSource.gallery)
                ),
                CupertinoButton(
                  borderRadius: BorderRadius.all(Radius.circular(0.0)),
                  //color: Colors.cyanAccent.withOpacity(0.2),
                  child: Text(
                    'Tomar foto',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.45),
                      fontSize: size.width * 0.049
                    ),
                  ),
                  onPressed: ()=>_procesarImagen(context, usuarioBloc, ImageSource.camera )
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  void _procesarImagen(BuildContext context, UsuarioBloc usuarioBloc, ImageSource origenImg)async{
    PickedFile pickedFile = await _imagePicker.getImage(
      source: origenImg
    );
    _imagenSeleccionada = File(pickedFile.path);
    if(pickedFile != null){
      print('**********************');
      print('pickedFile: ');
      print(_imagenSeleccionada);
    }
    Navigator.of(context).pop();
  /*
    await ImagePicker.pickImage(
    source: origenImg,
  );
  */
  }
}

