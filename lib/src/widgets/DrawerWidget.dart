import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:domicilios_cali/src/models/usuarios_model.dart';
import 'package:domicilios_cali/src/pages/perfil_page.dart';
import 'package:domicilios_cali/src/pages/productos_catalogo_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//importaciones locales
import 'package:domicilios_cali/src/pages/home_page.dart';
import 'package:domicilios_cali/src/pages/productos_tienda_page.dart';

class DrawerWidget extends StatelessWidget {
  UsuarioModel _usuario;

  @override
  Widget build(BuildContext context) {
    UsuarioBloc usuarioBloc = Provider.usuarioBloc(context);
    _usuario = usuarioBloc.usuario;
    _usuario.avatar = 'https://i.pinimg.com/originals/e1/7f/f3/e17ff3375ec7a91b07e6ae4bb338ce95.jpg';

    final size = MediaQuery.of(context).size;
    double nombreUsuarioFontSize = size.width * 0.045;
    double subtituloFontSize = size.width * 0.05;
    double nombreElementoFontSize = size.width * 0.043;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(top: 41.0),    
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom:size.height * 0.02),
            child: Row(
              children: <Widget>[
                SizedBox(width: size.width * 0.03,),
                CircleAvatar(
                  backgroundImage: NetworkImage(_usuario.avatar),
                  radius: 25.0,
                  
                ),
                SizedBox(width: size.width * 0.05,),
                Text(
                  _usuario.name, 
                  style: TextStyle(fontSize: nombreUsuarioFontSize),
                ),
              ],
            ),
          ),
          Divider(
            height: 3.0,
            color: Colors.black,
          ),
          ListTile(
            title: Text('Inicio', style: TextStyle(fontSize: nombreElementoFontSize),),
            leading: Icon(Icons.home),
            onTap: (){
              Navigator.pushReplacementNamed(context, HomePage.route);
            },
          ),
          ListTile(
            title: Text('Catálogo productos', style: TextStyle(fontSize: nombreElementoFontSize),),
            leading: Icon(Icons.list),
            onTap: (){
              Navigator.pushReplacementNamed(context, ProductosCatalogoPage.route);
            },
          ),
          ListTile(
            title: Text('Monedero', style: TextStyle(fontSize: nombreElementoFontSize),),
            leading: Icon(Icons.monetization_on),
            onTap: (){

            },
          ),
          Divider(
            height: 3.0,
            color: Colors.black,
          ),
          Container(
            width: double.infinity,
            height: size.height * 0.219,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 6.0),
                  child: Text('Mi tienda', style: TextStyle(fontSize: subtituloFontSize),),
                ),
                ListTile(
                  leading: Icon(Icons.featured_play_list),
                  title: Text('Productos', style: TextStyle(fontSize: nombreElementoFontSize)),
                  onTap: (){
                    Navigator.pushReplacementNamed(context, ProductosTiendaPage.route);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.card_giftcard),
                  title: Text('Domicilio', style: TextStyle(fontSize: nombreElementoFontSize)),
                  onTap: (){

                  },
                ),
              ],
            ),
          ),
          Divider(
            height: 1.0,
            color: Colors.black,
          ),
          Container(
            width: double.infinity,
            height: size.height * 0.152,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: size.height * 0.03),
                  child: Text('Mis compras', style: TextStyle(fontSize: subtituloFontSize),),
                ),
                ListTile(
                  leading: Icon(Icons.featured_play_list),
                  title: Text('Lista compras', style: TextStyle(fontSize: nombreElementoFontSize)),
                  onTap: (){

                  },
                ),
              ],
            ),
          ),
          Divider(
            height: 1.0,
            color: Colors.black,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil', style: TextStyle(fontSize: nombreElementoFontSize)),
            onTap: (){
              Navigator.pushReplacementNamed(context, PerfilPage.route);
            },
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('salir', style: TextStyle(fontSize: nombreElementoFontSize)),
            onTap: (){

            },
          ),
        ],
      ),
    );
  }
}