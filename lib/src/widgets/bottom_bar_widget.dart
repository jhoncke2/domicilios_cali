import 'package:domicilios_cali/src/bloc/navigation_bloc.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:domicilios_cali/src/pages/direccion_create_page.dart';
import 'package:domicilios_cali/src/pages/favoritos_page.dart';
import 'package:domicilios_cali/src/pages/home_page.dart';
import 'package:domicilios_cali/src/pages/pasos_crear_tienda_page.dart';
import 'package:domicilios_cali/src/pages/perfil_page.dart';
import 'package:flutter/material.dart';
class BottomBarWidget extends StatefulWidget {
  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  Color _unselectedItemColor;
  Color _selectedItemColor;
  IconThemeData _unselectedIconTheme;
  IconThemeData _selectedIconTheme;

  @override
  Widget build(BuildContext context) {
    NavigationBloc navigationBloc = Provider.navigationBloc(context);
    UsuarioBloc usuarioBloc = Provider.usuarioBloc(context);
    String token = usuarioBloc.token;
    Size size = MediaQuery.of(context).size;
    _generarStylesYThemes();
    return BottomNavigationBar(
      iconSize: size.width * 0.075,
      selectedItemColor: _selectedItemColor,
      unselectedItemColor: _unselectedItemColor,
      backgroundColor: Colors.blueAccent,
      selectedIconTheme: _selectedIconTheme,
      unselectedIconTheme: _unselectedIconTheme,
      onTap: (int newIndex){
        
        if(newIndex!=3){
          navigationBloc.index = newIndex;
          Navigator.of(context).pushNamed(navigationBloc.routeByIndex);
        }     
        else{
          if(usuarioBloc.usuario != null)
            _mostrarMenu(context, size, usuarioBloc, navigationBloc, token, newIndex);
          else{
            navigationBloc.index = newIndex;
            Navigator.of(context).pushNamed(navigationBloc.routeByIndex);
          }
        }         
        setState(() {
          
        });
      },
      currentIndex: navigationBloc.index,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              'Inicio',
              style: TextStyle(
                fontSize: size.width * 0.042,
              ),  
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text(
              'Buscar',
              style: TextStyle(
                fontSize: size.width * 0.042,
              ),  
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.line_style),
            title: Text(
              'Pedidos',
              style: TextStyle(
                fontSize: size.width * 0.042,
              ),  
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            title: Text(
              'Cuenta',
              style: TextStyle(
                fontSize: size.width * 0.042,
              ),  
            )
          ),
      ],
      showUnselectedLabels: true,
    );
  }

  Future<void> _mostrarMenu(BuildContext context, Size size, UsuarioBloc usuarioBloc, NavigationBloc navigationBloc, String token, int newIndex)async{
    String valor = await showMenu<String>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(size.width * 0.055),
          topRight: Radius.circular(size.width * 0.055)
        )
      ),
      context: context, 
      position: RelativeRect.fromLTRB(
        size.width * 0.4, 
        size.height * 0.065, 
        size.width - 1, 
        size.height * 0.855
      ),
      items: [
        PopupMenuItem(
          enabled: false,
          value: 'imagen',
          child: Container(
            padding: EdgeInsets.only(bottom:size.height * 0.045),
            child: Center(
              child: Image.asset(
                'assets/iconos/logo_porta_01.png',
                fit: BoxFit.fill,
                width: size.width * 0.37,
                height: size.height * 0.074,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: 'perfil',
          height: size.height * 0.08,
          child: _crearChildPopUpMenuItem(size, 0, 'Perfil', Icons.person),
        ),
        PopupMenuItem(
          value: 'favoritos',
          child: _crearChildPopUpMenuItem(size, 1, 'Favoritos', Icons.favorite),
          height: size.height * 0.08,
        ),
        PopupMenuItem(
          value: 'tienda',
          child: _crearChildPopUpMenuItem(size, 2, 'Ofrecer productos para venta', Icons.monetization_on),
          height: size.height * 0.08,
        ),
        PopupMenuItem(
          value: 'salir',
          child: _crearChildPopUpMenuItem(size, 3, 'Salir', Icons.open_in_new),
          height: size.height * 0.08,     
        ),
        PopupMenuItem(
          value: 'bottom',
          enabled: false,
          height: size.height * 0.387,
          child: Container(),
        )
      ],
    );
    if(valor!=null){
      navigationBloc.index = newIndex;
    }
    switch(valor){
      case 'perfil':
        Navigator.of(context).pushNamed(PerfilPage.route);
        break;
      case 'favoritos':
        Navigator.of(context).pushNamed(FavoritosPage.route);
        break;
      case 'tienda':
        Navigator.of(context).pushNamed(DireccionCreatePage.route, arguments: 'tienda');
        break;
      case 'salir':
        _logOut(usuarioBloc, navigationBloc, token);
        break;
      default:
        break; 
    }   
  }
  
  Widget _crearChildPopUpMenuItem(Size size, int index, String nombre, IconData icono){
    return Container(
      height: size.height * 0.08,
      margin: EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(((index < 3)? 0.45: 0.0)),
            width: 1.35
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            nombre,
            style: TextStyle(
              color: Colors.black.withOpacity(0.55),
              fontSize: size.width * 0.045,
              fontFamily: 'OpenSansCondensed',
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            icono,
            size: size.width * 0.058,
            color: Colors.grey.withOpacity(0.85),
          ),
        ],
      ),
    );
  }

  void _logOut(UsuarioBloc usuarioBloc, NavigationBloc navigationBloc, String token)async{
    await usuarioBloc.logOut(token);
    navigationBloc.reiniciarIndex();
    Navigator.pushReplacementNamed(context, HomePage.route);
  }

  void _generarStylesYThemes(){
    _unselectedItemColor = Colors.black.withOpacity(0.6);
    _selectedItemColor = Colors.black.withOpacity(0.9);
    _selectedIconTheme = IconThemeData(
      color: Colors.black.withOpacity(0.8),
    );
    _unselectedIconTheme = IconThemeData(
      color: Colors.grey.withOpacity(0.8),
    );
  }
}