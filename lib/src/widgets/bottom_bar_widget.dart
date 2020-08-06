import 'package:domicilios_cali/src/bloc/navigation_bloc.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/tienda_bloc.dart';
import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:domicilios_cali/src/pages/direccion_create_page.dart';
import 'package:domicilios_cali/src/pages/domiciliario_create_page.dart';
import 'package:domicilios_cali/src/pages/domiciliarios_page.dart';
import 'package:domicilios_cali/src/pages/favoritos_page.dart';
import 'package:domicilios_cali/src/pages/home_page.dart';
import 'package:domicilios_cali/src/pages/perfil_page.dart';
import 'package:domicilios_cali/src/pages/productos_tienda_page.dart';
import 'package:domicilios_cali/src/pages/solicitud_de_pedidos_page.dart';
import 'package:domicilios_cali/src/pages/ventas_page.dart';
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
    
    List<PopupMenuEntry<String>> menuItems = _agregarMenuItems(size, usuarioBloc, navigationBloc, token);
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
      items: menuItems,
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
              
        TiendaBloc tiendaBloc = Provider.tiendaBloc(context);
        if(!tiendaBloc.enCreacion){
          tiendaBloc.iniciarCreacionTienda();
          Navigator.of(context).pushNamed(DireccionCreatePage.route, arguments: 'tienda');
        }else
          Navigator.of(context).pushNamed(PerfilPage.route);
          
        break;
      case 'productos':
        Navigator.of(context).pushNamed(ProductosTiendaPage.route);
        break;
      case 'solicitud_de_pedidos':
        Navigator.of(context).pushNamed(SolicitudDePedidosPage.route);
        break;
      case 'ventas':
        Navigator.of(context).pushNamed(VentasPage.route);
        break;
      case 'domiciliarios':
        Navigator.of(context).pushNamed(DomiciliariosPage.route);
        
        break;
      case 'salir':
        _logOut(usuarioBloc, navigationBloc, token);
        break;
      default:
        break; 
    }   
  }

  List<PopupMenuEntry<String>> _agregarMenuItems(Size size, UsuarioBloc usuarioBloc, NavigationBloc navigationBloc, String token){
    List<PopupMenuEntry<String>> items = [
      PopupMenuItem<String>(
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
      PopupMenuItem<String>(
        value: 'perfil',
        height: size.height * 0.08,
        child: _crearChildPopUpMenuItem(size, usuarioBloc, 0, 'Perfil', Icons.person),
      ),
      PopupMenuItem<String>(
        value: 'favoritos',
        child: _crearChildPopUpMenuItem(size, usuarioBloc, 1, 'Favoritos', Icons.favorite),
        height: size.height * 0.08,
      ),
      PopupMenuItem<String>(
        value: 'tienda',
        enabled: !usuarioBloc.usuario.hasStore,
        child: _crearChildPopUpMenuItem(size, usuarioBloc, 2, 'Ofrecer productos para venta', Icons.monetization_on),
        height: size.height * 0.08,
      ),
    ];

    if(usuarioBloc.usuario.hasStore){
      items.addAll([
        PopupMenuItem<String>(
          value: 'productos',
          child: _crearChildPopUpMenuItem(size, usuarioBloc, 3, 'Productos', Icons.monetization_on),
          height: size.height * 0.055,
        ),
        PopupMenuItem<String>(
          value: 'solicitud_de_pedidos',
          child: _crearChildPopUpMenuItem(size, usuarioBloc, 4, 'Solicitud de pedidos', Icons.monetization_on),
          height: size.height * 0.055,
        ),
        PopupMenuItem<String>(
          value: 'ventas',
          child: _crearChildPopUpMenuItem(size, usuarioBloc, 5, 'Ventas', Icons.monetization_on),
          height: size.height * 0.055,
        ),
        PopupMenuItem<String>(
          value: 'domiciliarios',
          child: _crearChildPopUpMenuItem(size, usuarioBloc, 6, 'Domiciliarios', Icons.monetization_on),
          height: size.height * 0.055,
        ),
      ]);
    }

    items.addAll([
      PopupMenuItem<String>(
          value: 'salir',
          child: _crearChildPopUpMenuItem(size, usuarioBloc, 7, 'Salir', Icons.open_in_new),
          height: size.height * 0.08,     
        ),
        PopupMenuItem<String>(
          value: 'bottom',
          enabled: false,
          height: ((usuarioBloc.usuario.hasStore)? size.height * 0.16: size.height * 0.387),
          child: Container(),
        )
    ]);
    return items;
  }
  
  Widget _crearChildPopUpMenuItem(Size size, UsuarioBloc usuarioBloc, int index, String nombre, IconData icono){
    bool esTiendaSubItem = (usuarioBloc.usuario.hasStore && 2 < index && index < 7);
    return Container(
      height: size.height * (esTiendaSubItem? 0.055 : 0.08),
      margin: (esTiendaSubItem)?EdgeInsets.only(left: size.width * 0.06):EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(((usuarioBloc.usuario.hasStore && index < 7)? 0.45: 0.0)),
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
          ((!esTiendaSubItem)?
          Icon(
            icono,
            size: size.width * 0.058,
            color: Colors.grey.withOpacity(0.85),
          )
          : SizedBox()
          )
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